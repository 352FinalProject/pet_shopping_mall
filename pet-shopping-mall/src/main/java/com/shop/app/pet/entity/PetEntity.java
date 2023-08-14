ackage com.shop.app.pet.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDate;

@Entity
public class Pet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private LocalDate birthday;
    private String type;
    private String breed;
    private LocalDate adoptionDate;
    private String gender;

    // 생성자, getter, setter 메서드
}