//package com.shop.app.wishlist.controller;
//
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.web.bind.annotation.*;
//
//import javax.validation.Valid;
//
//
//@Slf4j
//@RestController
//@RequestMapping("/wishlist/myWishlist")
//public class WishlistController {
//
//    private final WishlistService wishlistService;
//
//    // 새로운 Wishlist 데이터를 추가하는 엔드포인트
//    @PostMapping
//    public ResponseResult<?> insert(@RequestBody @Valid WishlistDto wishlistRequestDTO) throws Exception {
//        wishlistService.insert(wishlistRequestDTO);
//        return success();
//    }
//
//    // Wishlist 데이터를 삭제하는 엔드포인트
//    @DeleteMapping
//    public ResponseResult<?> delete(@RequestBody @Valid WishlistDto wishlistRequestDTO) {
//        wishlistService.delete(wishlistRequestDTO);
//        return success();
//    }
//
//}

package com.shop.app.wishlist.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shop.app.wishlist.service.WishlistService;

@Controller
public class WishlistController {

    @Autowired
    private WishlistService wishlistService; // WishlistService를 주입받음

    @GetMapping("/check-like")
    public String checkLikeProduct(
            @RequestParam("productId") int productId, // 요청 파라미터에서 productId 값을 받아옴
            @RequestParam("memberId") String memberId, // 요청 파라미터에서 memberId 값을 받아옴
            Model model) { // Spring의 Model 객체를 이용하여 뷰에 데이터를 전달

        // WishlistService를 사용하여 제품과 회원의 찜 여부 체크
        int likeCount = wishlistService.getLikeProduct(productId, memberId);

        // Model에 likeCount 값을 추가하여 뷰로 전달
        model.addAttribute("likeCount", likeCount);

        // "like-check-result" 뷰로 이동하여 결과를 표시
        return "like-check-result"; // 해당 뷰의 이름 반환
    }
}

