package com.example.QuinstionProfile.service;


import com.example.QuinstionProfile.dto.AccountDto;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface AccountService {

    public AccountDto createAccount(AccountDto accountDto);
    public AccountDto viewAccount(String accountId);
    public int updateScore(String accountId, int score);
}
