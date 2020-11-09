package mirea.pois.mkryukov;

public class Car {
    private final Owner owner;
    private final Integer ownersMax;

    public Car (Owner owner, Integer ownersMax){
        this.owner = owner;
        this.ownersMax = ownersMax;
    }

    public Integer getOwnersMax() {
        return ownersMax;
    }

    public Owner getOwner() {
        return owner;
    }
}
