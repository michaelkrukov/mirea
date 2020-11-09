package mirea.pois.mkryukov;

import java.util.Random;

public class Owner {
    private final Integer regionNumber;
    private final Double bonusMalus;
    private final Integer age;
    private final Integer experience;

    public Owner(Integer regionNumber, Integer age, Integer experience) {
        this.regionNumber = regionNumber;
        this.age = age;
        this.experience = experience;
        this.bonusMalus = 0.5 + 2.5 * (new Random(age + experience + regionNumber)).nextDouble();
    }

    public Integer getRegionNumber() {
        return regionNumber;
    }

    public Double getBonusMalus() {
        return bonusMalus;
    }

    public Integer getAge() {
        return age;
    }

    public Integer getExperience() {
        return experience;
    }
}
