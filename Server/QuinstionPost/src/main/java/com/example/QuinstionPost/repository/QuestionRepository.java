package com.example.QuinstionPost.repository;

import com.example.QuinstionPost.entity.Question;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionRepository extends MongoRepository<Question,String> {
    List<Question> findByCategory(String Category);
    List<Question> findByAccountId(String accountId);
}
