package com.example.QuinstionProfile.service.impl;

import com.example.QuinstionProfile.dto.*;
import com.example.QuinstionProfile.entity.Account;
import com.example.QuinstionProfile.entity.FollowersAndFollowing;
import com.example.QuinstionProfile.entity.Notification;
import com.example.QuinstionProfile.repository.AccountRepository;
import com.example.QuinstionProfile.repository.FollowersAndFollowingRepository;
import com.example.QuinstionProfile.repository.NotificationRepository;
import com.example.QuinstionProfile.service.AccountService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class AccountServiceImpl implements AccountService {

    @Autowired
    AccountRepository accountRepository;

    @Autowired
    FollowersAndFollowingRepository followersAndFollowingRepository;

    @Autowired
    NotificationRepository notificationRepository;

    public AccountDto createAccount(AccountDto accountDto) {

        try {
            Account account = new Account();
            BeanUtils.copyProperties(accountDto, account);
            account.setScoreBatch("basic");
            account.setScore(0);
            accountRepository.save(account);
            accountDto.setId(account.getId());
//             todo : should not be calling save twice to set this stupid accountId value .. - completed
//             todo : instead always copy accountId to id from DTO to entity and vice versa - completed

            FollowersAndFollowing followersAndFollowing = new FollowersAndFollowing();
            followersAndFollowing.setAccountId(account.getId());
            followersAndFollowing.setFollowRequests(new ArrayList<>());
            followersAndFollowing.setFollowers(new ArrayList<>());
            followersAndFollowing.setFollowing(new ArrayList<>());
            followersAndFollowingRepository.save(followersAndFollowing);

            RestTemplate restTemplate = new RestTemplate();
            String resourceUrl = "http://10.20.4.96:9090/search/saveUser/";
            System.out.println(resourceUrl);
            restTemplate.postForEntity(resourceUrl,account,Void.class);

//            System.out.println(account);
            return accountDto;
        }
        catch (Exception e) {
            System.out.println(e);
            return null;
        }

    }

    public int updateScore(String accountId, int score){
        Optional<Account> account = accountRepository.findById(accountId);
        if (account.isPresent()){
            Account account1 = new Account();
            BeanUtils.copyProperties(account.get(),account1);
            int currentScore = account1.getScore();
            currentScore = currentScore + score;
            if (currentScore<0)
                currentScore = 0;
            account1.setScore(currentScore);

            String scoreBatch = account.get().getScoreBatch();


            if((currentScore>11) && (currentScore<=20)) {
                scoreBatch = "silver";

            }
            else if((currentScore>21) && (currentScore<=30)) {
                scoreBatch = "gold";
            }
            else if(currentScore>31){
                scoreBatch = "platinum";
            }

            account1.setScoreBatch(scoreBatch);

            System.out.println(scoreBatch);

            accountRepository.save(account1);
            return currentScore;
        }
        else{
            System.out.println("account is empty");
            return score;
        }

    }

    public AccountDto viewAccount(String accountId) {
        AccountDto accountDto = new AccountDto();
        // todo : change this to query based on findById .. - completed

        Optional<Account> optionalAccount = accountRepository.findById(accountId);
        if (optionalAccount.isPresent()) {
            // todo : exists checks are missing before you access the object .. not the code to be developed in second project - completed
            BeanUtils.copyProperties(optionalAccount.get(), accountDto);
            Optional<FollowersAndFollowing> followersAndFollowing = followersAndFollowingRepository.findByAccountId(accountId);
            if (followersAndFollowing.isPresent()) {
                accountDto.setNoOfFollowers(followersAndFollowing.get().getFollowers().size());
                accountDto.setNoOfFollowing(followersAndFollowing.get().getFollowing().size());
                List<String> followingId = followersAndFollowing.get().getFollowing();
                List<ViewMiniProfileDto> returnFollowing = new ArrayList<>();
                for (String s : followingId) {
                    Optional<Account> account = accountRepository.findById(s);
                    if (account.isPresent()) {
                        ViewMiniProfileDto viewMiniProfileDto = new ViewMiniProfileDto();
                        viewMiniProfileDto.setId(account.get().getId());
                        viewMiniProfileDto.setUserName(account.get().getUserName());
                        viewMiniProfileDto.setProfileImage(account.get().getProfileImage());

                        returnFollowing.add(viewMiniProfileDto);
                    }
                }
                accountDto.setFollowing(returnFollowing);

                List<String> followerId = followersAndFollowing.get().getFollowers();
                List<ViewMiniProfileDto> returnFollower = new ArrayList<>();
                for (String s : followerId) {
                    Optional<Account> account = accountRepository.findById(s);
                    if (account.isPresent()) {
                        ViewMiniProfileDto viewMiniProfileDto = new ViewMiniProfileDto();
                        viewMiniProfileDto.setId(account.get().getId());
                        viewMiniProfileDto.setProfileImage(account.get().getProfileImage());
                        viewMiniProfileDto.setUserName(account.get().getUserName());
                        returnFollower.add(viewMiniProfileDto);
                    }
                }
                accountDto.setFollowers(returnFollower);
                return accountDto;
            } else {
                return null;
            }
        }
        else
        {
            return null;
        }
    }

}
