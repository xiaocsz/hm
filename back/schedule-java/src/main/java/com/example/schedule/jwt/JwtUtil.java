package com.example.schedule.jwt;

import com.example.schedule.common.JwtParseException;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.security.Keys;

import java.util.Base64;
import java.util.Date;
import java.security.Key;

public class JwtUtil {


    // Access Token 的密钥
    public static final String ACCESS_SECRET_KEY = "kz8s9XO9qNB0Uk4z0hWZ2e7qPz6yP3Alg/UeZn9do4c=";
    // Refresh Token 的密钥
    public static final String REFRESH_SECRET_KEY = "kz8s9XO9qNB0Uk4z0hWZ2e7qPz6yP3Alg/UeZn9do4c=";

    // 生成 Access Token
    public static String generateAccessToken(String username) {
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + 1000 * 60 * 60 * 24 * 7);  // 15分钟后过期

        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(now)
                .setExpiration(expiryDate)
                .signWith(Keys.hmacShaKeyFor(Base64.getDecoder().decode(ACCESS_SECRET_KEY)))
                .compact();
    }

    // 生成 Refresh Token
    public static String generateRefreshToken(String username) {
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + 1000 * 60 * 60 * 24 * 7);  // 7天后过期

        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(now)
                .setExpiration(expiryDate)
                .signWith(Keys.hmacShaKeyFor(Base64.getDecoder().decode(REFRESH_SECRET_KEY)))
                .compact();
    }

    // 提取用户名（从 Access Token 或 Refresh Token 中解析）
    public static String extractUsername(String token) {
        return extractUsername(token, ACCESS_SECRET_KEY);  // 默认用 Access Token 的密钥解析
    }

    public static String extractUsername(String token, String secretKey) {
        try {
            Key key = Keys.hmacShaKeyFor(Base64.getDecoder().decode(secretKey));
            Claims claims = Jwts.parser()
                    .setSigningKey(key)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
            return claims.getSubject();
        } catch (JwtException | IllegalArgumentException e) {
            // 捕获解析 JWT 时的异常
            throw new JwtParseException("Invalid or expired JWT token", e);  // 抛出自定义的异常
        }
    }

    // 判断 Token 是否过期
    public static boolean isTokenExpired(String token) {
        Date expiration = Jwts.parser()
                .setSigningKey(Keys.hmacShaKeyFor(Base64.getDecoder().decode(ACCESS_SECRET_KEY)))
                .build()
                .parseClaimsJws(token)
                .getBody()
                .getExpiration();
        return expiration.before(new Date());
    }

    // 校验 Token 是否有效
    public static boolean validateToken(String token, String username) {
        return (username.equals(extractUsername(token)) && !isTokenExpired(token));
    }


}

