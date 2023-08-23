package com.shop.app.wishlist.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;


@Slf4j
@RestController
@RequestMapping("/wishlist/myWishlist")
public class WishlistController {

    private final WishlistService wishlistService;

    // 새로운 Wishlist 데이터를 추가하는 엔드포인트
    @PostMapping
    public ResponseResult<?> insert(@RequestBody @Valid WishlistDto wishlistRequestDTO) throws Exception {
        wishlistService.insert(wishlistRequestDTO);
        return success();
    }

    // Wishlist 데이터를 삭제하는 엔드포인트
    @DeleteMapping
    public ResponseResult<?> delete(@RequestBody @Valid WishlistDto wishlistRequestDTO) {
        wishlistService.delete(wishlistRequestDTO);
        return success();
    }

}
