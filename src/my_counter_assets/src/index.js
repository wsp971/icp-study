import { my_counter } from "../../declarations/my_counter";

const countShow = document.querySelector("#countShow");
const input = document.querySelector("input[name='inputCount']");
const setButton = document.querySelector('#set');
const incrementButton = document.querySelector('#increment');



(async function(){
  function getCount(){
    return my_counter.get();
  }
  function setCount(count){
    return my_counter.set(count);
  }
  function increment(){
    return my_counter.increment();
  }
  async function updateCount(){
    const count = await getCount();
    countShow.innerText = count;
  }
  
  updateCount();

  setButton.addEventListener('click',async ()=>{
    console.log('set count...');
    try{
      const value = input.value || 0;
      await setCount(Number(value));
      await updateCount();
    }catch(e){
      console.log('error',e);
    }
  });

  incrementButton.addEventListener("click",async ()=>{
    console.log('increment');
    await increment();
    await updateCount();
  })

})()

