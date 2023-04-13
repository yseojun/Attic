%시침, 분침, 초침을 나타낼 벡터 생성
secv = [0; 1];
minv = [0; 0.75];
hourv = [0; 0.4];

%degree 배열 생성, 6도로 분할
degree = 0:6:360;
degree = deg2rad(degree);

%숫자를 표시할 위치에 쓸 벡터 생성
numv = [0; 1.2];

sec=55;
min=60;
hour=6; % hour는 "1 + 5n" 으로만 수정 가능
%바로 확인할 수 있는 시간으로 만들어 둠

while 1
    clf;
    %창 생성, 이전 항목 유지
    axis([-2 2 -2 2]);
    hold on;
    %시간 단위로 벡터 회전 및 숫자 표시
    for h = 1:12
        rot_matrix = [cos(-degree(h * 5)) -sin(-degree(h * 5)); sin(-degree(h * 5)) cos(-degree(h * 5))];
        vn = rot_matrix * numv;
        text(vn(1,1), vn(2,1), num2str(h), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    end
    %원 생성 (사각형 생성 후 곡률)
    rectangle('Position',[-1,-1,2,2],'Curvature',[1 1],'EdgeColor','k','LineWidth',2);
    %벡터 표현, 벡터에 회전 행렬을 곱해서, 원하는 위치로 회전시킨다
    rot_matrix = [cos(-degree(hour)) -sin(-degree(hour)); sin(-degree(hour)) cos(-degree(hour))];
    v3 = rot_matrix * hourv;
    quiver(0, 0, v3(1, 1), v3(2, 1), 'b');
    rot_matrix = [cos(-degree(min)) -sin(-degree(min)); sin(-degree(min)) cos(-degree(min))];
    v2 = rot_matrix * minv;
    quiver(0, 0, v2(1, 1), v2(2, 1), 'g');
    rot_matrix = [cos(-degree(sec)) -sin(-degree(sec)); sin(-degree(sec)) cos(-degree(sec))];
    v1 = rot_matrix * secv;
    quiver(0, 0, v1(1, 1), v1(2, 1), 'r');
    sec=sec+1;
    %시간 변수 조절, sec = 60 -> min++, min = 60 -> hour += 5
    %만들어 둔 1~61까지의 배열로 rot_matrix를 조절하므로 배열 인덱스를 넘어가는 60을 넘기면 1로 초기화
    if sec > 60 %sec > 61 이 아닌 이유는 61 == 1 이기 때문에, 표현을 중복으로 하게 됨
        sec = 1;
        min = min + 1;
    end
    if min > 60
        min = 1;
        hour = hour + 5;
    end
    if hour > 60
        hour = 1;
    end
    pause(1); %시간 조절
end
