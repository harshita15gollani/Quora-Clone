package com.example.QuinstionProfile.controller;

import com.example.QuinstionProfile.dto.*;
import com.example.QuinstionProfile.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;


@CrossOrigin("*")
@RestController
@RequestMapping("/account")
public class AccountController {

    @Autowired
    AccountService accountService;

    @PostMapping(value = "/signup")
    public AccountDto save(@RequestBody AccountDto accountDto){
        SignUpDto signUpDto=new SignUpDto();
        signUpDto.setGender(accountDto.getGender());
        signUpDto.setEmail(accountDto.getEmail());
        signUpDto.setMobile(accountDto.getPhoneNumber());
        signUpDto.setPassword(accountDto.getPassword());
        signUpDto.setName(accountDto.getUserName());
        signUpDto.setSocialMediaId(3);
        SignUpResponseDto signUpResponseDto=null;
        RestTemplate restTemplate=new RestTemplate();
        try{
            signUpResponseDto=restTemplate.postForObject("http://10.20.3.120:8111/user/signup",signUpDto,SignUpResponseDto.class);
            System.out.println(signUpResponseDto);
            System.out.println(signUpResponseDto.getUserId());
            accountDto.setId(signUpResponseDto.getUserId());
            System.out.println(accountDto.getId());
            return accountService.createAccount(accountDto);
        }
        catch (Exception e){
            System.out.println(e);
            return null;
        }

    }


    @PostMapping(value="/createAccount")
    AccountDto createAccount(@RequestBody AccountDto accountDto){
//        SignUpDto signUpDto = new SignUpDto();
//        signUpDto.setName(accountDto.getUserName());
//        signUpDto.setPassword(accountDto.getPassword());
//        signUpDto.setSocialMediaId(3);
//        signUpDto.setMobile(accountDto.getPhoneNumber());
//        signUpDto.setEmail(accountDto.getEmail());
//        signUpDto.setGender(accountDto.getGender());
//        SignUpResponseDto signUpResponseDto = null;
//        RestTemplate restTemplate = new RestTemplate();
//        try{
//            signUpResponseDto = restTemplate.postForObject("http://10.20.3.120:8111/user/signup",signUpDto,SignUpResponseDto.class);
//            System.out.println(signUpResponseDto);
//            System.out.println(signUpResponseDto.getUserId());
//        }
//        catch (Exception e)
//        {
//            System.out.println(e);
//        }

        return accountService.createAccount(accountDto);

    }


    @GetMapping(value = "/viewAccount/{accountId}")
    AccountDto viewAccount(@PathVariable("accountId") String accountId){
        return accountService.viewAccount(accountId);
    }

    @PostMapping(value="/updateScore/{accountId}/{score}")
    int updateScore(@PathVariable("accountId") String accountId, @PathVariable("score") int score){
        return accountService.updateScore(accountId, score);
    }

//
//    @PostMapping(value = "login")
//    AccountDto accountLogin(@RequestBody LoginDto loginDto){
//        SignUpResponseDto signUpResponseDto = null;
//        RestTemplate restTemplate = new RestTemplate();
//        try{
//            signUpResponseDto = restTemplate.postForObject("http://10.20.3.120:8111/user/login",loginDto,SignUpResponseDto.class);
//            System.out.println(signUpResponseDto);
//        }
//        catch (Exception e)
//        {
//            System.out.println(e);
//        }
//        return null;
//    }

}
