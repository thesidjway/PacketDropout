function [minimal_signals] = algorithm_minimal(num_dropouts_allowed, length)

%% Initialization G(V1,E1)
num_states = num_dropouts_allowed + 1;
if num_states < 2
    return
end
Gprev = digraph; %G is the automaton graph
for i = 1:num_states
    Gprev = Gprev.addnode(int2str(i));
end
for i=1:num_states
    Gprev = Gprev.addedge(int2str(i), int2str(num_states),1);
end
for i=1:num_states-2
    Gprev = Gprev.addedge(int2str(i), int2str(i+1), 0);
end
Gprev = Gprev.addedge(int2str(num_states), int2str(1), 0);

Ginit = Gprev; % G(V,E)

%% i-product lifting
Gcurr = digraph;
for i = 2:length
    Gcurr = digraph;
    for j = 1:num_states
        Gcurr = Gcurr.addnode(int2str(j));
    end
    for j = 1:size(Gprev.Edges,1) % iterating through each edge
        nodeprev = Gprev.Edges.EndNodes(j,1);
        weightprev = Gprev.Edges(j,:).Weight;
        oe = outedges(Ginit, Gprev.Edges.EndNodes(j,2)); % Edges emerging from the end node of the prev edge
        for k = 1: size(oe,1)
            nodenext = Ginit.Edges(oe(k),:).EndNodes(1,2);
            weight = Ginit.Edges(oe(k),:).Weight;
            Gcurr = Gcurr.addedge(nodeprev, nodenext, weightprev*2 + weight);
        end
    end
    
    j = 1;
    while j < size(Gcurr.Edges,1)
        nodeprev = Gcurr.Edges.EndNodes(j,1);
        nodecurr = Gcurr.Edges.EndNodes(j,2);
        if(Gcurr.edgecount(nodeprev, nodecurr) > 1)
            dup_edges = Gcurr.findedge(nodeprev , nodecurr);
            l = 1;
            while l < size(dup_edges,1)
                m = l+1;
                while m < size(dup_edges,1)
                    if compare(Gcurr.Edges(dup_edges(l),:).Weight, Gcurr.Edges(dup_edges(m),:).Weight)
                        Gcurr = Gcurr.rmedge(dup_edges(m));
                        dup_edges = Gcurr.findedge(nodeprev , nodecurr);
                        m = m - 1;
                        j = j - 1;
                    end
                    m = m + 1;
                end
                l = l + 1;
            end
        end
        j = j + 1;
    end
    
    Gprev = Gcurr;
    plot(Gcurr,'EdgeLabel',Gcurr.Edges.Weight)
end

end