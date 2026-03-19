package com.divyesh.prep.service;

import com.divyesh.prep.model.User;
import com.divyesh.prep.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public int addUser(User user) {
        return userRepository.addUser(user);
    }

    public User getUser(String uuid) {
        return userRepository.getUser(uuid);
    }

    public List<User> getUsers() {
        return userRepository.getUsers();
    }
}
