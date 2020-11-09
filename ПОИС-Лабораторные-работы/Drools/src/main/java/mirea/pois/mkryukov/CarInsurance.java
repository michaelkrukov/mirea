package mirea.pois.mkryukov;

import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

import java.util.ArrayList;
import java.util.List;

public class CarInsurance {
    private Double price;
    private Car car;
    private List<Double> multipliers;
    private Double finalPrice;

    public CarInsurance(Double price, Car car) {
        this.price = price;
        this.car = car;
        multipliers = new ArrayList<>();
    }

    public void addMultiplier(Double multiplier) {
        multipliers.add(multiplier);
    }

    public boolean areMultipliersAvailable() {
        return !multipliers.isEmpty();
    }

    public void calculatePrice() {
        Double tmpFinalPrice = price;

        for (Double multiplier: multipliers) {
            tmpFinalPrice *= multiplier;
        }

        tmpFinalPrice *= getCar().getOwner().getBonusMalus();

        finalPrice = tmpFinalPrice;
    }

    public Double getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(Double finalPrice) {
        this.finalPrice = finalPrice;
    }

    public List<Double> getMultipliers() {
        return multipliers;
    }

    public void setMultipliers(List<Double> multipliers) {
        this.multipliers = multipliers;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public static void main(String[] args) {
        try {
            KieServices ks = KieServices.Factory.get();
            KieContainer kContainer = ks.getKieClasspathContainer();
            KieSession kSession = kContainer.newKieSession("ksession-rules");

            Car car = new Car(new Owner(50, 22, 3), 1);
            CarInsurance ci = new CarInsurance(15000.0, car);

            kSession.insert(ci);
            kSession.fireAllRules();
        } catch (Throwable t){
            t.printStackTrace();
        }
    }
}
