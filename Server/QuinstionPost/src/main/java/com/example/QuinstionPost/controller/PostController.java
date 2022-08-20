package com.example.QuinstionPost.controller;

import com.example.QuinstionPost.Dto.ReturnPostsDto;
import com.example.QuinstionPost.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("/posts")
public class PostController {

    @Autowired
    PostService postService;

    @GetMapping(value = "/viewPost/{accountId}")
    public List<ReturnPostsDto> viewPost(@PathVariable("accountId") String accountId){
        return postService.viewPost(accountId);
    }

    @GetMapping(value = "/myPost/{accountId}")
    public List<ReturnPostsDto> myPost(@PathVariable("accountId") String accountId){
        return postService.myPost(accountId);
    }

}
