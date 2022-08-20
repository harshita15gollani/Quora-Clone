package com.example.QuinstionPost.service.impl;

import com.example.QuinstionPost.Dto.*;
import com.example.QuinstionPost.entity.Answer;
import com.example.QuinstionPost.entity.Comment;
import com.example.QuinstionPost.entity.Question;
import com.example.QuinstionPost.repository.AnswerRepository;
import com.example.QuinstionPost.repository.CommentRepository;
import com.example.QuinstionPost.repository.QuestionRepository;
import com.example.QuinstionPost.service.PostService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;


@Service
public class PostServiceImpl implements PostService {

    @Autowired
    QuestionRepository questionRepository;

    @Autowired
    AnswerRepository answerRepository;


    @Autowired
    CommentRepository commentRepository;

    @Override
    // todo : code in each method should not exceed 25 lines .. break this into smaller pieces of logic
    public List<ReturnPostsDto> viewPost(String accountId) {

        RestTemplate restTemplate = new RestTemplate();
        String resourceUrl = "http://10.20.4.131:8080/FollowersAndFollowingController/FollowingList/"+accountId;
        ResponseEntity<FollowingDto> responseEntity = restTemplate.getForEntity(resourceUrl, FollowingDto.class);

        List<ReturnPostsDto> returnPostsDto = new ArrayList<>();
        List<String> followingList = responseEntity.getBody().getFollowing();


        // todo : move this logic to findAllByIds .. list of followers instead of firing one database query for each user in a loop
        for(String s : followingList){
            List<Question> questionList = questionRepository.findByAccountId(s);
            for(Question q: questionList){
                ReturnPostsDto tempPost = new ReturnPostsDto();
                tempPost.setAccountId(q.getAccountId());
                tempPost.setCategory(q.getCategory());
                tempPost.setAlive(true);
                tempPost.setCodeEmbed(q.getCodeEmbed());
                tempPost.setDescription(q.getDescription());
                tempPost.setNumberOfDownvotes(q.getNumberOfDownvotes());
                tempPost.setNumberOfUpvotes(q.getNumberOfUpvotes());
                tempPost.setUrlEmbed(q.getUrlEmbed());
                tempPost.setQuestionId(q.getId());
                tempPost.setProfileImage(q.getProfileImage());
                tempPost.setUserName(q.getUserName());

                // todo : fetch using all question ids .. and maintain in mem data structure to map things quicker
                List<Answer> answerList = answerRepository.findByQuestionId(q.getId());
                List<ReturnAnsDto> answerListDto = new ArrayList<>();
                for(Answer a : answerList){
                    ReturnAnsDto ans = new ReturnAnsDto();
                    BeanUtils.copyProperties(a,ans);
                    ans.setAnswerId(a.getId());
                    ans.setUserName(a.getUserName());
                    ans.setProfileImage(a.getProfileImage());

                    List<ReturnCommentDto> commentDtoList = new ArrayList<>();
                    // todo : fetch using all question ids .. and maintain in mem data structure to map things quicker
                    List<Comment> commentList =  commentRepository.findByAnswerId(a.getId());
                    for(Comment c :commentList){
                        ReturnCommentDto temp = new ReturnCommentDto();
                        BeanUtils.copyProperties(c,temp);
                        temp.setCommentId(c.getId());
                        temp.setUserName(c.getUserName());
                        temp.setProfileImage(c.getProfileImage());
                        commentDtoList.add(temp);
                    }
                    ans.setCommentsLevel(commentDtoList);
                    answerListDto.add(ans);
                }
                tempPost.setAnswersList(answerListDto);
                returnPostsDto.add(tempPost);
            }
        }
        return returnPostsDto;
    }


    // todo : execute the data using bulk query
    // todo : lot of duplication of code from previous method .. reduce code and develop reusable methods
    @Override
    public List<ReturnPostsDto> myPost(String accountId) {

        List<ReturnPostsDto> returnPostsDto = new ArrayList<>();
        List<Question> questionList = questionRepository.findByAccountId(accountId);
        System.out.println(questionList);
        for (Question q : questionList){
            ReturnPostsDto tempReturnPostsDto = new ReturnPostsDto();
            tempReturnPostsDto.setAccountId(q.getAccountId());
            tempReturnPostsDto.setUserName(q.getUserName());
            tempReturnPostsDto.setProfileImage(q.getProfileImage());
            tempReturnPostsDto.setQuestionId(q.getId());
            tempReturnPostsDto.setUrlEmbed(q.getUrlEmbed());
            tempReturnPostsDto.setCodeEmbed(q.getCodeEmbed());
            tempReturnPostsDto.setNumberOfUpvotes(q.getNumberOfUpvotes());
            tempReturnPostsDto.setNumberOfDownvotes(q.getNumberOfDownvotes());
            tempReturnPostsDto.setCategory(q.getCategory());
            tempReturnPostsDto.setAlive(q.isAlive());
            tempReturnPostsDto.setDescription(q.getDescription());

            List<Answer> answerList = answerRepository.findByQuestionId(q.getId());
            List<ReturnAnsDto> returnAnsDtoList = new ArrayList<>();
            for(Answer a:answerList){
                ReturnAnsDto ans = new ReturnAnsDto();
                BeanUtils.copyProperties(a, ans);
                ans.setAnswerId(a.getId());
                ans.setUserName(a.getUserName());
                ans.setProfileImage(a.getProfileImage());
                List<ReturnCommentDto> returnCommentDtosList = new ArrayList<>();
                List<Comment> commentList = commentRepository.findByAnswerId(a.getId());

                for (Comment c:commentList){
                    ReturnCommentDto temp = new ReturnCommentDto();
                    BeanUtils.copyProperties(c,temp);
                    temp.setCommentId(c.getId());
                    temp.setProfileImage(c.getProfileImage());
                    temp.setUserName(c.getUserName());
                    returnCommentDtosList.add(temp);
                }
                ans.setCommentsLevel(returnCommentDtosList);
                returnAnsDtoList.add(ans);
            }
            tempReturnPostsDto.setAnswersList(returnAnsDtoList);
            returnPostsDto.add(tempReturnPostsDto);
        }
        return returnPostsDto;
    }
}
