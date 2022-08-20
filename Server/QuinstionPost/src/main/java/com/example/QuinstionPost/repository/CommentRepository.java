package com.example.QuinstionPost.repository;

import com.example.QuinstionPost.entity.Comment;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends MongoRepository<Comment,String> {

    List<Comment> findByAnswerId(String answerId);
    List<Comment> findByAnswerIdAndLevel(String answerId, int level);
    List<Comment> findByParentId(String answerId);

}
