package com.example.QuinstionPost.service.impl;

import com.example.QuinstionPost.Dto.AccountDto;
import com.example.QuinstionPost.Dto.AnswerDto;
import com.example.QuinstionPost.Dto.QuestionDto;
import com.example.QuinstionPost.entity.Answer;
import com.example.QuinstionPost.entity.Question;
import com.example.QuinstionPost.repository.AnswerRepository;
import com.example.QuinstionPost.service.AnswerService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class AnswerServiceImpl implements AnswerService {

    @Autowired
    AnswerRepository answerRepository;

    public AnswerDto addAnswer(AnswerDto answerDto, String accountId) {


        //rest template to get username and profileimage
        // todo : do you need this call?
        // todo : if this is required for notification .. make this code async .. not part of the main thread
        RestTemplate restTemplate = new RestTemplate();
        String resourceUrl = "http://localhost:8080/account/viewAccount/"+accountId;
        ResponseEntity<AccountDto> responseEntity = restTemplate.getForEntity(resourceUrl, AccountDto.class);
        System.out.println(responseEntity);


        Answer answerToBePosted = new Answer();
        BeanUtils.copyProperties(answerDto,answerToBePosted);
        answerToBePosted.setAccountId(accountId);
        answerToBePosted.setAnswerDescription(answerDto.getAnswerDescription());
        answerToBePosted.setUserName(responseEntity.getBody().getUserName());
        answerToBePosted.setProfileImage(responseEntity.getBody().getProfileImage());
        LocalDateTime localDate = LocalDateTime.now();
        answerToBePosted.setDateModified(Date.from(localDate.atZone(ZoneId.systemDefault()).toInstant()));
        answerRepository.save(answerToBePosted);
        answerDto.setAnswerId(answerToBePosted.getId());
        return answerDto;
    }

    @Override
    public List<AnswerDto> findByQuestionId(String questionId) {
        List<Answer> allAnswers = answerRepository.findByQuestionId(questionId);
        if (!allAnswers.isEmpty()) {
            List<AnswerDto> allAnswerDto = new ArrayList<>();
            for (Answer answer : allAnswers) {
                AnswerDto answerDto = new AnswerDto();
                BeanUtils.copyProperties(answer, answerDto);
            }
            return allAnswerDto;
        }
        else
        {
            System.out.println("allAnswers is empty");
            return null;
        }
    }

    // todo : changes to the count between upvote and downvote needs to be handled
    @Override
    public void upVote(String answerId) {
        // todo : upvote should be inplace update .. not load the object to update and save

        Optional<Answer> answer = answerRepository.findById(answerId);
        if (answer.isPresent()) {
            answer.get().setNumberOfUpvotes(answer.get().getNumberOfUpvotes() + 1);
            answerRepository.save(answer.get());

            RestTemplate restTemplate = new RestTemplate();
            String resourceUrl = "http://localhost:8080/account/updateScore/"+answer.get().getAccountId() +"/"+1;
            restTemplate.postForObject(resourceUrl,null,Void.class);
        }
        else{
            System.out.println("answer is empty");
        }
    }

    // todo : changes to the count between upvote and downvote needs to be handled
    @Override
    public void downVote(String answerId) {
        // todo : downvote should be inplace update .. not load the object to update and save
        Optional<Answer> answer = answerRepository.findById(answerId);
        if (answer.isPresent()) {
            answer.get().setNumberOfDownvotes(answer.get().getNumberOfDownvotes() + 1);
            answerRepository.save(answer.get());

            RestTemplate restTemplate = new RestTemplate();
            String resourceUrl = "http://localhost:8080/account/updateScore/"+answer.get().getAccountId() +"/"+-1;
            restTemplate.postForObject(resourceUrl,null,Void.class);
        }
        else {
            System.out.println("answer is empty");
        }
    }
}
