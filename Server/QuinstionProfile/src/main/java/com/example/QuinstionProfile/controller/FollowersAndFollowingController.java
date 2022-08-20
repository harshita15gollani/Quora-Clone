package com.example.QuinstionProfile.controller;


import com.example.QuinstionProfile.dto.FollowingDto;
import com.example.QuinstionProfile.service.FollowersAndFollowingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin("*")
@RestController
@RequestMapping(value = "/FollowersAndFollowingController")
public class FollowersAndFollowingController {

    @Autowired
    FollowersAndFollowingService followersAndFollowingService;

    @PostMapping(value = "/FollowRequest/{requesterId}/{requestingId}")
     void FollowRequest(@PathVariable("requesterId") String requesterId,@PathVariable("requestingId")  String requestingId){
        followersAndFollowingService.FollowRequest(requesterId,requestingId);
    }

    @PostMapping(value = "/AcceptRequest/{requesterId}/{requestingId}")
    void AcceptRequest(@PathVariable("requesterId") String requesterId, @PathVariable("requestingId") String requestingId)
    {
        followersAndFollowingService.AcceptRequest(requesterId,requestingId);
    }

    @PostMapping(value="/DeclineRequest/{requesterId}/{requestingId}")
    void DeclineRequest(@PathVariable("requesterId") String requesterId, @PathVariable("requestingId") String requestingId){
        followersAndFollowingService.DeclineRequest(requesterId,requestingId);
    }

    @GetMapping(value = "FollowingList/{accountId}")
    FollowingDto viewFollowingList(@PathVariable("accountId") String accountId){
        return followersAndFollowingService.viewFollowingList(accountId);
    }
}
