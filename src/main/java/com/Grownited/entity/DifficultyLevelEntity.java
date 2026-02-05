package com.Grownited.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "difficulty_level")
public class DifficultyLevelEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer difficultyId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, unique = true)
    private Level level;

    private Boolean active;

    public enum Level {
        EASY,
        MEDIUM,
        HARD,
        BEGINNER
    }

    public DifficultyLevelEntity() {
        this.active = true;
    }

    public Integer getDifficultyId() {
        return difficultyId;
    }

    public void setDifficultyId(Integer difficultyId) {
        this.difficultyId = difficultyId;
    }

    public Level getLevel() {
        return level;
    }

    public void setLevel(Level level) {
        this.level = level;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }
}
