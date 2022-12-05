var 스크린 = document.querySelector("#screen"); // screen 태그를 가져옴
var 시작시간;
var 끝시간;
var 기록 = [];
var 타임아웃;

스크린.addEventListener("click", function () {
  if (스크린.classList.contains("waiting")) {
    // 현재 클래스를 확인 가능합니다.
    스크린.classList.remove("waiting"); // 클릭시 waiting을 지우고
    스크린.classList.add("ready"); // ready를 추가
    스크린.textContent = "초록색이 되면 클릭하세요";
    타임아웃 = setTimeout(function () {
      시작시간 = new Date();
      스크린.click();
    }, Math.floor(Math.random() * 1000) + 2000); // 2000~3000 사이수
  } else if (스크린.classList.contains("ready")) {
    //준비상태
    if (!시작시간) {
      // !는 true를 false false를 true로 바꿔줍니다. 쉽게 말하면 참 거잣을 바꿔줍니다.
      // 부정클릭
      clearTimeout(타임아웃); // settimeout을 지울수 있다.
    } else {
      스크린.classList.remove("ready"); // 클릭시 waiting을 지우고
      스크린.classList.add("now"); // ready를 추가
      스크린.textContent = "클릭하세요!";
    }
  } else if (스크린.classList.contains("now")) {
    // 시작상태
    끝시간 = new Date();
    console.log("반응속도", 끝시간 - 시작시간, "ms");
    alert("반응속도", 끝시간 - 시작시간, "ms");
    기록.push(끝시간 - 시작시간);
    시작시간 = null;
    끝시간 = null; // 다음 게임을 위해서 초기화
    스크린.classList.remove("now");
    스크린.classList.add("waiting");
    스크린.textContent = "클릭해서 시작하세요";
  }
});