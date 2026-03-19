package com.divyesh.prep.controller;

import com.divyesh.prep.model.User;
import com.divyesh.prep.service.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public List<User> getUsers() {
        return userService.getUsers();
    }

    @GetMapping("/{uuid}")
    public User getUser(@PathVariable String uuid) {
        return userService.getUser(uuid);
    }

    @PostMapping
    public String addUser(@RequestBody User user) {
        int rows = userService.addUser(user);
        return (rows > 0) ? "User added" : "User add failed";
    }
}
