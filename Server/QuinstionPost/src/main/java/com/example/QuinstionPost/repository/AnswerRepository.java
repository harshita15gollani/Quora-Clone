package com.example.QuinstionPost.repository;

import com.example.QuinstionPost.entity.Answer;
import com.example.QuinstionPost.entity.Question;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnswerRepository extends MongoRepository<Answer,String> {
    List<Answer> findByQuestionId(String questionId);

}
