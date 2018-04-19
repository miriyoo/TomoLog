package lets.eat.cancho.comment.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lets.eat.cancho.comment.vo.Comment;

@Repository
public class CommentDAO {

	private static final Logger logger = LoggerFactory.getLogger(CommentDAO.class);
	
	@Autowired
	SqlSession session;
	
	public void insertComment(Comment comment){
		
		logger.info("댓글 달기 시작");
		
		CommentMapper mapper = session.getMapper(CommentMapper.class);
		
		try{
			mapper.insertComment(comment);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		logger.info("댓글 달기 종료");
	}
	
	public ArrayList<Comment> readComment(int post_num){
		
		logger.info("댓글 목록 불러오기");
		
		ArrayList<Comment> commentList = null;
		CommentMapper mapper = session.getMapper(CommentMapper.class);
		
		try{
			commentList = mapper.readComment(post_num);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		logger.info("댓글 목록 불러오기 완료");
		
		return commentList;
	}
	
	public void deleteComment(int comment_num){
		
		logger.info("댓글 삭제 시작");
		
		CommentMapper mapper = session.getMapper(CommentMapper.class);
		
		try{
			mapper.deleteComment(comment_num);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		logger.info("댓글 삭제 완료");
	}
	
	public void updateComment(Comment comment){
		
		logger.info("댓글 수정 시작");
		
		CommentMapper mapper = session.getMapper(CommentMapper.class);
		
		try{
			mapper.updateComment(comment);
			
		} catch(Exception e){
			e.printStackTrace();
		}
		
		logger.info("댓글 수정 완료");
	}
	
	
}