import io.jenetics.BitChromosome;
import io.jenetics.BitGene;
import io.jenetics.Genotype;
import io.jenetics.Optimize;
import io.jenetics.engine.Engine;
import io.jenetics.engine.EvolutionResult;
import io.jenetics.util.Factory;

import java.util.HashSet;
import java.util.Set;


public class Main {
    private static int eval(boolean[][] matrix, Genotype<BitGene> gt) {
        BitChromosome bc = gt.chromosome().as(BitChromosome.class);
        Set<String> result = new HashSet<>();

        int max = 0;
        for (boolean[] row: matrix) {
            for (boolean val: row) {
                max += val ? 1 : 0;
            }
        }
        max /= 2;

        int vertices = 0;

        for (int i = 0; i < bc.length(); i++) {
            if (bc.booleanValue(i)) {
                vertices += 1;

                for (int j = 0; j < matrix.length; j++) {
                    if (matrix[i][j]) {
                        if (i < j) {
                            result.add(String.format("%d:%d", i, j));
                        } else {
                            result.add(String.format("%d:%d", j, i));
                        }
                    }
                }
            }
        }

        if (result.size() >= max) {
            return max - vertices;
        } else {
            return -max + result.size();
        }
    }

    public static void main(String[] args) {
        boolean[][] matrix = new boolean[][] {
                new boolean[] {false, true, false, false, true, false},
                new boolean[] {true, false, true, false, true, false},
                new boolean[] {false, true, false, true, false, false},
                new boolean[] {false, false, true, false, true, true},
                new boolean[] {true, true, false, true, false, false},
                new boolean[] {false, false, false, true, false, false},
        };

        Factory<Genotype<BitGene>> gtf =
                Genotype.of(BitChromosome.of(6, 0.5));

        Engine<BitGene, Integer> engine = Engine
                .builder((v) -> Main.eval(matrix, v), gtf)
                .populationSize(50)
                .optimize(Optimize.MAXIMUM)
                .build();


        Genotype<BitGene> resultGenotype = engine.stream()
                .limit(1000)
                .collect(EvolutionResult.toBestGenotype());

        BitChromosome result = resultGenotype.chromosome().as(BitChromosome.class);

        System.out.println("Result:\n" + result.toCanonicalString() + " (" + eval(matrix, resultGenotype) + ")");
        System.out.println("(Expected something like \"010110 (4)\" or \"110100 (4)\")");
    }
}
