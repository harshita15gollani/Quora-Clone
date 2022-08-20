package com.example.QuinstionProfile.service;

import com.example.QuinstionProfile.dto.FollowingDto;

public interface FollowersAndFollowingService {
    void FollowRequest(String requesterId, String requestingId);
    void AcceptRequest(String requesterId, String requestingId);
    void DeclineRequest(String requesterId, String requestingId);
    FollowingDto viewFollowingList(String accountId);
}
