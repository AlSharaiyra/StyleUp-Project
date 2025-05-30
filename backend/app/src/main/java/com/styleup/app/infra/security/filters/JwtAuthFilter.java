package com.styleup.app.infra.security.filters;

import com.styleup.app.infra.constants.ErrorCodes;
import com.styleup.app.infra.exception.InvalidCredentialsException;
import com.styleup.app.repository.entity.UserPrincipal;
import com.styleup.app.service.CustomUserDetailsService;
import com.styleup.app.service.JwtService;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

import static com.styleup.app.infra.constants.ErrorCodes.EXPIRED_CREDENTIALS;
import static com.styleup.app.infra.constants.ErrorCodes.INVALID_CREDENTIALS;

@Component
@RequiredArgsConstructor
public class JwtAuthFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final CustomUserDetailsService customUserDetailsService;

    @Override
    protected void doFilterInternal(final HttpServletRequest request,
                                    final HttpServletResponse response,
                                    final FilterChain filterChain)
            throws ServletException, IOException {

        final String authHeader = request.getHeader("Authorization");

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }

        try {
            final String jwt = authHeader.substring(7);
            final String username = jwtService.extractUsername(jwt);

            if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                UserPrincipal user = (UserPrincipal) customUserDetailsService.loadUserByUsername(username);

                if (jwtService.isTokenValid(jwt, user.getUsername(), user.getRevokedTokensBefore()) && jwtService.isAccessToken(jwt)) {
                    var authToken = new UsernamePasswordAuthenticationToken(
                            user, null, user.getAuthorities());

                    authToken.setDetails(
                            new WebAuthenticationDetailsSource().buildDetails(request));

                    SecurityContextHolder.getContext().setAuthentication(authToken);
                } else {
                    throw new InvalidCredentialsException("Invalid or expired access token", INVALID_CREDENTIALS);
                }
            }

            filterChain.doFilter(request, response);

        } catch (ExpiredJwtException e) {
            throw new InvalidCredentialsException("Access token has expired", EXPIRED_CREDENTIALS);
        } catch (JwtException e) {
            throw new InvalidCredentialsException("Invalid access token", INVALID_CREDENTIALS);
        }

    }

}