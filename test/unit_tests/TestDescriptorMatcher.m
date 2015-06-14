classdef TestDescriptorMatcher
    %TestDescriptorMatcher
    properties (Constant)
    end

    methods (Static)
        function test_1
            X = randn(50,3);
            Y = randn(10,3);
            matchers = [...
                cv.DescriptorMatcher('BruteForce'),...
                cv.DescriptorMatcher('BruteForce-L1'),...
                cv.DescriptorMatcher('BruteForce-SL2'),...
                cv.DescriptorMatcher('FlannBased'),...
                cv.DescriptorMatcher('BFMatcher',...
                    'NormType','L2', 'CrossCheck',false),...
                cv.DescriptorMatcher('FlannBasedMatcher',...
                    'Index',  {'KDTree', 'Trees',4},...
                    'Search', {'Checks',32, 'EPS',0, 'Sorted',true}...
                    )...
                ];
            for i = 1:numel(matchers)
                matchers(i).add(X);
                matchers(i).train();
                matchers(i).match(Y);
                matchers(i).knnMatch(Y,3);
                matchers(i).radiusMatch(Y,0.1);
            end
        end

        function test_2
            X = randi([0,255], [50,3], 'uint8');
            Y = randi([0,255], [10,3], 'uint8');
            matchers = [...
                cv.DescriptorMatcher('BruteForce-Hamming'),...
                cv.DescriptorMatcher('BruteForce-HammingLUT'),...
                ... cv.DescriptorMatcher('BruteForce-Hamming(2)')...
                ];
            for i = 1:numel(matchers)
                matchers(i).add(X);
                matchers(i).train();
                matchers(i).match(Y);
                matchers(i).knnMatch(Y,3);
                matchers(i).radiusMatch(Y,0.1);
            end
        end
    end

end