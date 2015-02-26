clc;
data=load('handwriting.data');
tic;
num=randperm(size(data,1));
samp_data=data(num,:);
train=1:33607;
test=33608:42009;
X= samp_data(train,3:end);
y= samp_data(train,1);
X1=samp_data(test,3:end);
op=samp_data(test,1);
k=14;  %%% change values of k, use cross-validation
ynew=zeros(size(X1,1),1);
D=zeros(size(X,1),1);
for i=1:size(X1,1)
        Y=y;
        Xnew=X1(i,:);
        for u=1:size(X)
            D(u,:)=norm(Xnew-X(u,:)); %% euclidean distance, could try cosine or another distance metric depending on input dataset
        end
        [p, pp]=sort(D);              %% sort in descnding order for cosine
        ind=pp(1:k);
        mins_y=Y(ind);
        ynew(i,:)=mode(mins_y);   %% select output class by majority vote
end
% mis=0;
% for i=1:size(op)
%     if op(i)~=ynew(i)
%         mis=mis+1;
%     end
% end
chec=(op~=ynew);
mis2=sum(chec);    %% count of misclassified datapoints
time_taken=toc;