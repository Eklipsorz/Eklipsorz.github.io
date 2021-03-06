---
title: "Introduction: Floyd Cycle Detection Algorithm"
date: 2020-07-20T22:15:13+08:00
draft: false
---

當你想解決任何一個需要檢測在多個相互連接的元素是否著環狀結構之場景，比如說
1. 道路模型。
2. 由多個有限狀態所組成的數學模型。
3. 有限輸入下在同一個函式$f(x)$所形成的結果，比如集合為${1,2}$，且f$(1)=2$以及$f(2)=1$，在這裏1和2就透過函式關係形成一個環狀結構。

你會怎麼檢測它？放棄它，反正以後碰不上？
當然我會建議不放棄它，畢竟你不能夠確定在未來路上不會遇上類似的問題，那麼正式進入正題，如果冷靜思考的話，其實不論哪一個場景，都可以將這些場景轉化成由多個節點所組成的結構：

![](https://static.coderbridge.com/img/Eklipsorz/621532712ce646c8b70a67f5a350987a.png)

或者

![](https://static.coderbridge.com/img/Eklipsorz/71a7c4d173b742a2a8bf624867f3b49e.png)

當我們轉換成如此的結構時，我們可以更容易以肉眼看出哪些模型存在著循環，在這裏我們可以知道List A是存在著循環，而List B由於尾巴部分並未跟前幾個節點相接，所以不構成循環。在這裡你或許會選擇以肉眼來辨識，但現實是當面對大量或者複雜的模型時，肉眼看會顯得效率太差，所以最好由電腦進行這樣的重複辨識工作。

可換作是電腦，它要如何辨識呢？畢竟他本身就不存在像人眼那樣的辨識模型，在這裏提供一個方法來幫助電腦辨識：Floyd's Cycle Detection Algorithm，傳說是由Robert W. Floyd所發明的演算法，所以以它的名字來命名，普遍上會以演算法的特色來稱呼：龜兔賽跑算法。顧名思義，這個算法會假設一隻烏龜和一隻兔子在這個許多節點構成的List結構進行賽跑，烏龜每次只能走一個節點，而兔子只能走二個節點，他們只要跑下去肯定能到循環裡，最終如果他們能在循環中碰面或者在同一點會合的話，就表示這個結構上存在著循環。(如下圖所示)

![](https://static.coderbridge.com/img/Eklipsorz/639ef0cdb9e44fb8ba9bf0640f408e78.png)

然而，如果兔子走到結構中的終點卻沒跟烏龜會合的話，那就表示著結構不存著循環。(如下圖)
![](https://static.coderbridge.com/img/Eklipsorz/9623638256374a6980bcdc2dc7662faf.png)

乍看之下這方法很簡單，但問題是這方法真能判別循環問題嗎？如果你對此也感到懷疑，歡迎到Proof章節來進行討論，但如果沒有的話，我可以告訴你這方法確實能判別循環問題，而非是運氣，另外也建議讀者您參考Pseudo Code以及Performance這兩個章節來看其代碼以及成本。

## Proof:How it works?
首先我們先來考慮擁有循環的結構(如下圖)，在循環之前可能會有N個點或者沒存在任何節點，而這N的值會影響著烏龜和兔子在循環中的初始位置，再來為了很好瞭解影響，設定了數字來表示循環中的第幾個節點，以$0$到$λ-1$來命名，而λ則是定義成循環中的長度-節點數，在這裡$λ=10$。

![](https://static.coderbridge.com/img/Eklipsorz/b3aa3ce20c84491f88048dbdfbf9cc5b.png)

首先我們先考慮著N=0時，兔子和烏龜會在循環的起點會合，並從那裡開始進行他們的賽跑。

![](https://static.coderbridge.com/img/Eklipsorz/43370832d77640f6bc2a56f902cb4bc8.png)

根據兔子走兩步和烏龜走一步的前提，當兔子走完一圈時，烏龜才走半圈，而兔子在走完一圈時，這時烏龜才走完一圈，此時他們倆就在一開始的點會合。

在這裡，我們會發現幾個有趣的觀察結果：
1. 兔子得走完一圈才有辦法跟烏龜會合(p.s 他們倆不動也能會合XD，但這不是在該方法的討論範圍內)
2. 兔子$H$的步數會是烏龜$T$的步數之一倍，換言之，$H=2T$。
3. 延伸第二個結果，若沒有循環的存在，他們倆就可能沒辦法會合，但若是給予循環的存在，等同強制添加$mod\ λ$運算至$H$和$T$上才能判斷他們是否會合（如下式），而如果都是一樣的話，便是代表在循環中會合；但如果都不是一樣，便是還未會合。

$H≡T$ ($mod\ λ$) 或者 $2T≡T$ ($mod\ λ$)

統整這三個觀察結果，我們會發現只要$T=λ$ 代入上式，兔子和烏龜會在第0個節點會合。接下來我們思考另一種情況，如果$N=1$時，這種代入結果會不會有所不同？

![](https://static.coderbridge.com/img/Eklipsorz/bf30d1c98c674f0ba3a687e951b9a1da.png)

從上圖可以觀察出當烏龜進入循環時的位置不是在與兔子在同一個節點，而是相差一個節點，這對於N=0所得出的觀察結果而言，兔子還是得走完一圈才有辦法和烏龜在同一點，而且也不影響著兔子和烏龜原本要走的步數，由於當烏龜進入循環時的兔子所在位置不同而改變了第三種觀察結果。

首先兔子在循環中的位置會變成：
$H'=H+1$

那麼這個新位置會不會影響和烏龜在同一點會合呢？只要我們按照圖上位置來模擬他們移動，最後會發現他們的確會在同一點會合，只是位置變成第$λ-1$個位置或者最後一個位置-第九個位置。

那麼第三個觀察結果會變成如下所示：
$H+1≡T$ ($mod\ λ$) 或 $2T+1≡T$ ($mod\ λ$)

接著我們再來思考一下$N=2$時，會有什麼樣的變化

![](https://static.coderbridge.com/img/Eklipsorz/88329716b59044c0919f757860933536.png)

同樣的，由於只是單純增加循環外面的節點，不會影響著第一、二個觀察結果，而第三個結果中的兔子預期位置：
$H'=H+2$

接著我們只要按照圖上位置來模擬他們移動就會發現他們的確也是會在同一點上會合，但這次是第$λ-2$個節點或者第8個節點上會合。如果考慮成$N=3$時，會發現會在第$λ-3$個節點或者第7個節點上會合，而$N=4$時，會發現在第$λ-4$個節點或者第6個節點上會合。

那麼最後我們來試著考慮著$N=M$的情況，而M的範圍為$[1,∞)$，而定義成這範圍是由於我們只限定於不存在循環以外的點以及存在$M$個循環以外的點，在此只討論後者，前者已在$N=0$討論過。

![](https://static.coderbridge.com/img/Eklipsorz/dbeec351d5144b7f8dababdfffe9dfd8.png)

在這$N=M$的情況下，會使得兔子預期位置變成：
$H'=H+M$

在這裡我們還不確定這種情況是否同樣地使烏龜和兔子會在同一點會合，所以我們先假設他們肯定能在某一點會合來找出矛盾或者驗證其正確性，換言之，先定義出這式子：

$H+M≡T$ ($mod\ λ$)

或者
$2T+M≡T$ ($mod\ λ$)

根據前面所述的第ㄧ、二觀察結果，兔子必須得至少繞ㄧ圈才有機會與烏龜會合，但這樣單純繞幾圈也只是與烏龜保持$M~(0.5λ+M)$個節點的距離，所以兔子和烏龜必須得多走個幾步才有機會會合，所以式子會變成如下：

$T=N_1λ+N_2$ (烏龜繞了$N_1$圈又$N_2$步)

$2(N_1λ+N_2)+M≡N_1λ+N_2$ ($mod\ λ$)

根據$mod λ$，我們可以化簡成：

$2N_2+M≡N_2$ ($mod\ λ$)

根據先前$N=2~4$情況得到的觀察結果，會發現都會在第$λ-N$個節點會合，那麼同樣地將其結果套用在上式時，會發現式子變成

$N_2=λ-M$

$2(λ-M)+M≡(λ-M) ($mod\ λ$)

$-M≡-M$ ($mod\ λ$)

而這相當於在第$λ-M$個節點或者第$λ-N$個節點會合

$λ-M≡λ-M$ ($mod\ λ$)

從這樣推論驗證了$N$在$[1,∞)$範圍內的節點數所構成循環時可以使兔子和烏龜在第$λ-N$個節點會合。

```
其中λ-M中的λ其實原本是考慮成N’λ，但由於最後還是會因爲mod λ而跟λ-M的最後結果一樣，且如果寫N’λ-M的話，會不容易理解，在這裏簡化成最後解。
```

此外，如果讀者願意花更多時間觀察的話，只要畫個圖並標示起點、會合點、距離的話(如下圖）

![](https://static.coderbridge.com/img/Eklipsorz/02dbad0e00f24461b848d19d99df8921.png)

，會發現只要$N$與$λ-N$相加就能構成循環長度，換言之，
![](https://static.coderbridge.com/img/Eklipsorz/aabcd32341684f9c977f0cd18a246bb8.png)

從會合點到起點2的距離剛好是$N$個節點。

還有如果我們限制烏龜只能在循環內走不到一圈來和兔子會合，會得到一個有趣的觀察結果，其中烏龜走不到半圈時會使兔子永遠會合不了，因此烏龜的步數要滿足走不到一圈以及會合的條件必須是半圈以上至一圈的範圍，所以，原本的式子會改變成如下：

$T=\frac{1}{2}+M_1$

$2(\frac{1}{2}+M_1)+M≡\frac{1}{2}+M_1$ ($mod\ λ$)

代入原式會形成：
$-M≡-M$ ($mod\ λ$)


這樣子的結果等同於先前驗證結果，換言之，烏龜只需要繞半圈以上至一圈的距離就能和兔子會合。

```
先前我們假設烏龜和兔子會花好幾圈又幾個節點才能使他們會合，在這好幾圈又幾個節點的範圍內包含了無數個排列組合，比如2圈又5個節點，現在我們利用限制發現了其實烏龜走不到半圈就能會合。但這過程中，兔子還是得至少走一圈才能會合。
```
稍微統整目前得到觀察結果，我們可以得到：

1. 兔子得走完一圈才有辦法跟烏龜會合(p.s 他們倆不動也能會合XD，但這不是在該方法的討論範圍內)
2. 兔子$H$的步數會是烏龜T的步數之一倍，換言之，$H=2T$。
3. 延伸第二個結果，若沒有循環的存在，他們倆就可能沒辦法會合，但若是給予循環的存在，等同強制添加$mod λ$運算至$H$和$T$上才能判斷他們是否會合（如下式），其中M為循環外的節點數，如果都是一樣的話，便是代表在循環中會合；但如果都不是一樣，便是還未會合。

$H+M≡T$ ($mod\ λ$)

4. 延伸第三個觀察結果，會發現兔子和烏龜的會合點會是第$λ-N$個節點或者第λ-M個節點
5. 循環起點到會合點的距離可以和循環以外的節點數構成循環長度，換言之，$λ = $循環起點到會合點的距離+ 循環以外的節點數。
6. 烏龜只需要繞半圈以上至一圈的距離就能和兔子會合。


前面兩個結果因爲本身不受循環以外的節點數影響，所以不會進行變動，但原本第三個結果會隨之影響，使之擴展成考慮成$M$個循環以外的節點，而第4~5個結果則是因爲第三個結果的推論過程而新增過來的。


<h2 id="1"> Pseudo Code</h2>

程式碼連結：bit.ly/2FKotVP

使用EAFP程式碼風格來取代過度的if-else檢查，並從中提升速度，另外先讓在try區塊中的兔子多走一步以避免while迴圈判斷到錯誤的情況，同時這樣子的移動方式並不會改變兔子和烏龜的會合結果，只不過變成$M+1$個循環外節點的情況來移動。

## Performance

時間複雜度：考慮該方法應用在不存在循環以及存在循環的場景中，能得到時間複雜度範圍會是$O(N_1+N_2)$~$O(N)$，其中的$N_1$是循環外的起點1至循環內的起點2的距離，而$N_2$是循環內的起點2至烏龜與兔子預計會合的點之間的距離（如下圖），而N為節點的總共數量，其中根據以下的第六個觀察結果會發現$N_2$是在烏龜花不到半圈得到的數值，所以$N≥N_1+N_2$。

## Section I Want
## 總結

我們稍微介紹這方法以及應用場景，並且在最後證明這方法的可行性，同時從證明過程得到六個有趣結果。

