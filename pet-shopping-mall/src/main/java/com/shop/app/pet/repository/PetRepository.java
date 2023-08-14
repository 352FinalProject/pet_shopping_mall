package com.shop.app.pet.repository;

import com.shop.app.pet.entity.Pet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PetRepository extends JpaRepository<Pet, Long> {
    // 필요한 추가적인 메서드 정의 가능
}