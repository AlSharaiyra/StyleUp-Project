package com.styleup.app.service;

import com.styleup.app.repository.entity.User;
import com.styleup.app.repository.entity.UserPrincipal;
import com.styleup.app.repository.repo.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;

/**
 * A custom user details service.
 *
 * @author Walid Sharaiyra
 * @version 1.0
 * @since 05/2025
 */
@RequiredArgsConstructor
@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with email: " + email));

        return new UserPrincipal(user);
    }
}
