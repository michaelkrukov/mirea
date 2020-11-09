import mirea.pois.mkryukov.Car;
import mirea.pois.mkryukov.CarInsurance;
import mirea.pois.mkryukov.Owner;
import org.junit.Test;
import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Optional;

import static org.junit.Assert.assertEquals;

public class CarInsuranceRulesTest {

    @Test
    public void pois_lab_2_drools_rules_test() {
        KieServices ks = KieServices.Factory.get();
        KieContainer kContainer = ks.getKieClasspathContainer();
        KieSession kSession = kContainer.newKieSession("ksession-rules");

        Car car = new Car(new Owner(50, 22, 3), 1);
        CarInsurance ci = new CarInsurance(15000.0, car);

        kSession.insert(ci);
        kSession.fireAllRules();

        ArrayList<Double> expectedMultipliers = new ArrayList<>(Arrays.asList(1.5, 1.8, 1.0, 2.311518778381066));

        assertEquals(expectedMultipliers, ci.getMultipliers());
        assertEquals(216396, ci.getFinalPrice().intValue());
    }
}
