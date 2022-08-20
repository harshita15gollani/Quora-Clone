package com.example.QuinstionPost.service;

import com.example.QuinstionPost.Dto.ReturnPostsDto;

import java.util.List;

public interface PostService {
    public List<ReturnPostsDto> viewPost(String accountId);
    public List<ReturnPostsDto> myPost(String accountId);
}
