package com.gao.lucene;

import java.io.StringReader;
import java.nio.file.Paths;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.highlight.Fragmenter;
import org.apache.lucene.search.highlight.Highlighter;
import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;
import org.apache.lucene.search.highlight.SimpleSpanFragmenter;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import com.gao.entity.Content;
import com.gao.util.DateUtil;
import com.gao.util.StringUtil;

public class BlogIndex {
	private Directory dir;

	/**
	 * ��ȡIndexWriterʵ��
	 * */
	private IndexWriter getWriter()throws Exception{
		dir = FSDirectory.open(Paths.get("/bloglucene"));
		SmartChineseAnalyzer analyzer = new SmartChineseAnalyzer();//�п�Ժ
		IndexWriterConfig iwc = new IndexWriterConfig(analyzer);
		IndexWriter writer = new IndexWriter(dir,iwc);
		return writer;
	}
	
	/**
	 * ��Ӳ�������
	 * */
	public void addIndex(Content content)throws Exception{
		IndexWriter writer = getWriter();
		Document doc = new Document();
		doc.add(new StringField("id", String.valueOf(content.getId()), Field.Store.YES));
		doc.add(new TextField("title", content.getTitle(), Field.Store.YES));
		doc.add(new StringField("createTime", DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"), Field.Store.YES));
		doc.add(new TextField("comment", content.getCommentNoTag(), Field.Store.YES));
		writer.addDocument(doc);
		writer.close();
	}
	
	/**	
	 * ��ѯ������Ϣ
	 */
	public List<Content> searchContent(String q)throws Exception{
		dir = FSDirectory.open(Paths.get("/bloglucene"));
		IndexReader reader = DirectoryReader.open(dir);
		IndexSearcher is = new IndexSearcher(reader);
		BooleanQuery.Builder booleanQuery = new BooleanQuery.Builder();
		SmartChineseAnalyzer analyzer = new SmartChineseAnalyzer();
		
		QueryParser parser = new QueryParser("title", analyzer);
		Query query = parser.parse(q);
		
		QueryParser parser2 = new QueryParser("comment", analyzer);
		Query query2 = parser2.parse(q);

		booleanQuery.add(query,BooleanClause.Occur.SHOULD);
		booleanQuery.add(query2,BooleanClause.Occur.SHOULD);
		
		TopDocs hits = is.search(booleanQuery.build(), 100);
		QueryScorer scorer = new QueryScorer(query);
		Fragmenter fragmenter = new SimpleSpanFragmenter(scorer);
		SimpleHTMLFormatter simpleHTMLFormatter = new SimpleHTMLFormatter("<b><font color='red'>","</font></b>");
		Highlighter highlighter = new Highlighter(simpleHTMLFormatter,scorer);
		highlighter.setTextFragmenter(fragmenter);
		
		List<Content> contentList = new LinkedList<Content>();
		for (ScoreDoc scoreDoc : hits.scoreDocs) {
			Document doc = is.doc(scoreDoc.doc);
			Content content = new Content();
			content.setId(Integer.parseInt(doc.get("id")));
			content.setCreateTimeStr(doc.get("createTime"));
			content.setCreateTime(DateUtil.formatString(doc.get("createTime"), "yyyy-MM-dd HH:mm:ss"));
			String title = doc.get("title");
			String comment = doc.get("comment");
			//String comment = StringEscapeUtils.escapeHtml(doc.get("comment"));//���ı���ı�ǩ���й���ת��
			if (title!=null) {
				TokenStream tokenStream = analyzer.tokenStream("title", new StringReader(title));
				String hTitle = highlighter.getBestFragment(tokenStream, title);
				if (StringUtil.isEmpty(hTitle)) {
					content.setTitle(title);
				}else {
					content.setTitle(hTitle);
				}
			}
			
			if (comment!=null) {
				TokenStream tokenStream = analyzer.tokenStream("comment", new StringReader(comment));
				String hComment = highlighter.getBestFragment(tokenStream, comment);
				if (StringUtil.isEmpty(hComment)) {
					if (comment.length()<=200) {
						content.setComment(comment);
					}else{
						content.setComment(comment.substring(0,200));
					}
				}else {
					content.setComment(hComment);
				}
			}
			contentList.add(content);
		}
		return contentList;
	}
	
	
	/**
	 * ɾ��ָ�����͵�����
	 * */
	
	public void deleteIndex(String contentId)throws Exception{
		IndexWriter writer = getWriter();
		writer.deleteDocuments(new Term("id",contentId));
		writer.forceMergeDeletes();//ǿ��ɾ��
		writer.commit();
		writer.close();
	}
	
	
	/**
	 * ���²�������
	 * */
	public void updateIndex(Content content)throws Exception{
		IndexWriter writer = getWriter();
		Document doc = new Document();
		doc.add(new StringField("id", String.valueOf(content.getId()), Field.Store.YES));
		doc.add(new TextField("title", content.getTitle(), Field.Store.YES));
		doc.add(new StringField("createTime", DateUtil.formatDate(new Date(), "yyyy-MM-dd HH:mm:ss"), Field.Store.YES));
		doc.add(new TextField("comment", content.getCommentNoTag(), Field.Store.YES));
		writer.updateDocument(new Term("id",String.valueOf(content.getId())), doc);
		writer.close();
	}
}
