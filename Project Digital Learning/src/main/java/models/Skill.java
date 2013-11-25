package models;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Skill implements Serializable {

    @Id
    @GeneratedValue

    private long skillId;
    @Column(columnDefinition = "varchar(25)")
    private String name;
    @Column(columnDefinition = "varchar(25)")
    private String level;
    @Column(columnDefinition = "varchar(250)")
    private String description;

    @ManyToOne
    private User user;

    public Skill() {
    }

    public Skill(long skillId, String name, String level) {
        this.setSkillId(skillId);
        this.setName(name);
        this.setLevel(level);
    }
    public Skill(String name) {
        this.setName(name);
    }

    /* Getters en setters voor de verschillende attributen van het Model */
    public long getSkillId() {
        return skillId;
    }

    public void setSkillId(long skillId) {
        if (skillId < 1) {
            throw new IllegalArgumentException(
                    "Work number may not be negative, value = " + skillId);
        }
        this.skillId = skillId;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the level
     */
    public String getLevel() {
        return level;
    }

    /**
     * @param level the level to set
     */
    public void setLevel(String level) {
        this.level = level;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * @return the user
     */
    public User getUser() {
        return user;
    }

    /**
     * @param user the user to set
     */
    public void setUser(User user) {
        this.user = user;
    }
}
