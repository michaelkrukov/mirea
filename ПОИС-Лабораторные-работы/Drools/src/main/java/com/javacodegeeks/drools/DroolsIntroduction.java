package com.javacodegeeks.drools;

import org.kie.api.KieServices;
import org.kie.api.runtime.KieContainer;
import org.kie.api.runtime.KieSession;

/**
 * This is a sample class to launch a rule.
 */
public class DroolsIntroduction {
    private String topic;
    
    public DroolsIntroduction(String topic) {
        this.topic = topic;
    }

    public String test(){return "asdg";}

    public static final void main(String[] args) {
        try {
            // load up the knowledge base
            KieServices ks = KieServices.Factory.get();
            KieContainer kContainer = ks.getKieClasspathContainer();
            KieSession kSession = kContainer.newKieSession("ksession-rules");

            kSession.insert(new DroolsIntroduction("Drools"));
            kSession.insert(new DroolsIntroduction("not drools"));
            kSession.insert(new DroolsIntroduction("Drools"));
            kSession.fireAllRules();
            
            kSession.setGlobal("topicLevel", "Beginner");
            kSession.insert(new DroolsIntroduction("Drools"));
            kSession.fireAllRules();
        } catch (Throwable t) {
            t.printStackTrace();
        }
    }

    public String getTopic() {
        return topic;
    }
        
    public String introduceYourself() {
        return "Drools 6.2.0.Final";
    }
}