package com.example.QuinstionProfile.service.impl;

import com.example.QuinstionProfile.dto.FollowingDto;
import com.example.QuinstionProfile.dto.NotificationDto;
import com.example.QuinstionProfile.dto.ViewMiniProfileDto;
import com.example.QuinstionProfile.entity.Account;
import com.example.QuinstionProfile.entity.FollowersAndFollowing;
import com.example.QuinstionProfile.entity.Notification;
import com.example.QuinstionProfile.repository.AccountRepository;
import com.example.QuinstionProfile.repository.FollowersAndFollowingRepository;
import com.example.QuinstionProfile.repository.NotificationRepository;
import com.example.QuinstionProfile.service.FollowersAndFollowingService;
import org.apache.kafka.common.protocol.types.Field;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class FollowersAndFollowingServiceImpl implements FollowersAndFollowingService {

    @Autowired
    FollowersAndFollowingRepository followersAndFollowingRepository;

    @Autowired
    AccountRepository accountRepository;

    @Autowired
    NotificationRepository notificationRepository;

    public synchronized void FollowRequest(String requesterId, String requestingId){

            // todo : asked you to develop logic to update the list with single save method, not like opening the object and adding and save
            // todo : explained with an example if two threads try to add followers .. you will miss data

            if (accountRepository.findById(requestingId).get().getAccountType().equalsIgnoreCase("public"))
                AcceptRequest(requesterId, requestingId);
            else {
                Optional<FollowersAndFollowing> followersAndFollowing = followersAndFollowingRepository.findByAccountId(requesterId);
                if (followersAndFollowing.isPresent()) {
                    followersAndFollowing.get().setAccountId(requesterId);
                    List<String> follower = followersAndFollowing.get().getFollowRequests();
                    follower.add(requestingId);
                    followersAndFollowing.get().setFollowRequests(follower);

                    FollowersAndFollowing followersAndFollowing1 = new FollowersAndFollowing();
                    BeanUtils.copyProperties(followersAndFollowing.get(), followersAndFollowing1);

                    followersAndFollowingRepository.save(followersAndFollowing1);
                }
            }
        }


    @Override
    public void AcceptRequest(String requesterId, String requestingId) {
        try{
            // todo : change the logic to add to collection without loading the object
            Optional<FollowersAndFollowing> followersAndFollowing = followersAndFollowingRepository.findByAccountId(requesterId);
            followersAndFollowing.get().setAccountId(requesterId);
            List<String> follower = followersAndFollowing.get().getFollowers();
            follower.add(requestingId);
            followersAndFollowing.get().setFollowers(follower);
            FollowersAndFollowing followersAndFollowing1 = new FollowersAndFollowing();
            BeanUtils.copyProperties(followersAndFollowing.get(), followersAndFollowing1);
//            followersAndFollowing.get().getFollowRequests().remove(followersAndFollowing.get().getFollowRequests().size()-1);
//            followersAndFollowingRepository.save(followersAndFollowing1);
            Optional<FollowersAndFollowing> followersAndFollowing2 = followersAndFollowingRepository.findByAccountId(requestingId);
            followersAndFollowing2.get().setAccountId(requestingId);
            List<String> following = followersAndFollowing2.get().getFollowing();
            following.add(requesterId);
            followersAndFollowing2.get().setFollowing(following);
            FollowersAndFollowing followersAndFollowing3 = new FollowersAndFollowing();
            BeanUtils.copyProperties(followersAndFollowing2.get(), followersAndFollowing3);
            followersAndFollowingRepository.save(followersAndFollowing3);

            Optional<Account> account = accountRepository.findById(requestingId);

            //notification
            Notification notificationDto = new Notification();
            notificationDto.setRecipientUserName(account.get().getUserName());
            notificationDto.setRecipientProfileImage(account.get().getProfileImage());
            notificationDto.setRecipientAccountId(requestingId);
            notificationDto.setDescription(account.get().getUserName() + " started following you. ");
            notificationDto.setAccountId(requesterId);
            System.out.println("accept request notification "+notificationDto);
            notificationRepository.save(notificationDto);

        }
        catch (Exception e)
        {
            System.out.println(e);
        }
    }

    @Override
    public void DeclineRequest(String requesterId, String requestingId){
        try{
            // todo : delete the object from the collection, without loading the object
            Optional<FollowersAndFollowing> followersAndFollowing = followersAndFollowingRepository.findByAccountId(requesterId);
            followersAndFollowing.get().setAccountId(requesterId);
            followersAndFollowing.get().getFollowRequests().remove(followersAndFollowing.get().getFollowRequests().size()-1);
            FollowersAndFollowing followersAndFollowing1 = new FollowersAndFollowing();
            BeanUtils.copyProperties(followersAndFollowing.get(), followersAndFollowing1);
            followersAndFollowingRepository.save(followersAndFollowing1);
        }
        catch (Exception e){
            System.out.println(e);
        }
    }

    public FollowingDto viewFollowingList(String accountId){
        System.out.println(accountId);
        Optional<FollowersAndFollowing> followersAndFollowing = followersAndFollowingRepository.findByAccountId(accountId);
        System.out.println(followersAndFollowing);
        if(followersAndFollowing.isPresent()) {
            System.out.println(followersAndFollowing.get().getFollowing());
            FollowingDto followingDto = new FollowingDto();
            followingDto.setAccountId(accountId);
            followingDto.setFollowing(followersAndFollowing.get().getFollowing());
            return followingDto;
        }
        else {
            System.out.println("No value Found");
        }
        return null;
    }

}
