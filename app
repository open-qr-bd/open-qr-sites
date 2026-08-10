<!DOCTYPE html>
<html lang="bn">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Open QR — লোড হচ্ছে...</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Baloo+Da+2:wght@500;600;700;800&family=Hind+Siliguri:wght@400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --ink:#241A15; --cream:#FBF7EE; --paper:#FFFFFF;
    --maroon:#7A2323; --maroon-deep:#4A1414; --gold:#E0A527; --teal:#2F6F5E;
    --line: rgba(36,26,21,0.09); --shadow: 0 10px 30px -12px rgba(74,20,20,0.18);
  }
  *{box-sizing:border-box; margin:0; padding:0;}
  html{scroll-behavior:smooth;}
  body{ background:var(--cream); color:var(--ink); font-family:'Hind Siliguri', sans-serif; display:flex; justify-content:center; padding:0 0 60px; }
  .app{ width:100%; max-width:430px; background:var(--cream); min-height:100vh; position:relative; }

  .loading, .notfound{ display:flex; flex-direction:column; align-items:center; justify-content:center; min-height:100vh; text-align:center; padding:24px; }
  .loading .spin{ width:40px; height:40px; border:4px solid var(--line); border-top-color:var(--maroon); border-radius:50%; animation:spin 0.9s linear infinite; margin-bottom:16px; }
  @keyframes spin{ to{ transform:rotate(360deg); } }
  .notfound h2{ font-family:'Baloo Da 2',sans-serif; font-size:20px; color:var(--maroon); margin-bottom:8px; }
  .notfound p{ font-size:13px; color:#7a6c60; }

  .ticker{ background:var(--maroon-deep); color:var(--gold); overflow:hidden; white-space:nowrap; padding:7px 0; font-family:'Poppins',sans-serif; font-size:11px; font-weight:500; }
  .ticker-track{ display:inline-block; padding-left:100%; animation: ticker-scroll 22s linear infinite; }
  .ticker-track span{ margin-right:36px; }
  @keyframes ticker-scroll{ from{ transform:translateX(0); } to{ transform:translateX(-100%); } }

  .reveal{ opacity:0; transform:translateY(16px); transition:opacity .55s ease, transform .55s ease; }
  .reveal.in{ opacity:1; transform:translateY(0); }
  .item:nth-child(even){ background:rgba(122,35,35,0.025); margin:0 -18px; padding-left:18px; padding-right:18px; border-radius:8px; }

  .hero{ position:relative; background:radial-gradient(140% 120% at 15% -20%, var(--maroon) 0%, var(--maroon-deep) 65%); padding:34px 22px 64px; color:#fff; overflow:hidden; isolation:isolate; }
  .hero-pattern{ position:absolute; inset:0; z-index:-1; opacity:.14; background-image:radial-gradient(circle,#fff 1.6px,transparent 1.6px); background-size:22px 22px; }
  .hero-top{ display:flex; align-items:center; justify-content:space-between; margin-bottom:16px; gap:10px; }
  .wheel{ width:38px; height:38px; flex:none; animation:spin2 7s linear infinite; }
  @keyframes spin2{ to{ transform:rotate(360deg); } }
  .badge-row{ display:flex; gap:6px; flex-wrap:wrap; }
  .eyebrow{ font-family:'Poppins',sans-serif; font-size:10.5px; letter-spacing:.14em; text-transform:uppercase; color:var(--gold); background:rgba(255,255,255,0.08); padding:5px 10px; border-radius:100px; border:1px solid rgba(255,255,255,0.16); }
  .status-pill{ font-family:'Poppins',sans-serif; font-size:10.5px; font-weight:600; padding:5px 10px; border-radius:100px; display:flex; align-items:center; gap:5px; }
  .status-pill.open{ background:rgba(60,180,120,.18); color:#8FE3B8; border:1px solid rgba(143,227,184,.35); }
  .status-pill.closed{ background:rgba(255,255,255,.1); color:#EFDFC9; border:1px solid rgba(255,255,255,.2); }
  .status-dot{ width:6px; height:6px; border-radius:50%; background:currentColor; }
  h1{ font-family:'Baloo Da 2', sans-serif; font-weight:800; font-size:34px; line-height:1.08; letter-spacing:-.01em; margin-top:8px; }
  .tagline{ margin-top:9px; font-size:13.5px; color:#EFDFC9; max-width:85%; }

  .info-card{ position:relative; margin:-40px 18px 0; background:var(--paper); border-radius:18px; box-shadow:var(--shadow); display:flex; overflow:hidden; z-index:3; }
  .info-card a{ flex:1; text-align:center; padding:14px 4px 12px; font-size:10.5px; color:var(--ink); text-decoration:none; border-right:1px solid var(--line); }
  .info-card>:last-child{ border-right:none; }
  .info-card .ic{ font-size:17px; display:block; margin-bottom:4px; }

  .search-wrap{ padding:16px 16px 0; }
  .search-box{ display:flex; align-items:center; gap:8px; background:var(--paper); border:1px solid var(--line); border-radius:14px; padding:11px 14px; box-shadow:var(--shadow); }
  .search-box input{ border:none; outline:none; flex:1; font-family:'Hind Siliguri',sans-serif; font-size:13.5px; background:transparent; color:var(--ink); }
  .search-clear{ display:none; border:none; background:var(--cream); color:var(--maroon); width:20px; height:20px; border-radius:50%; font-size:12px; cursor:pointer; }
  .search-clear.show{ display:block; }
  .no-results{ display:none; text-align:center; padding:24px 16px; color:#a89a8c; font-size:13px; }
  .no-results.show{ display:block; }

  .nav-wrap{ position:sticky; top:0; z-index:20; background:rgba(251,247,238,0.88); backdrop-filter:blur(10px); -webkit-backdrop-filter:blur(10px); padding-top:14px; border-bottom:1px solid var(--line); }
  .tabs{ display:flex; gap:8px; padding:0 16px 12px; overflow-x:auto; scrollbar-width:none; }
  .tabs::-webkit-scrollbar{ display:none; }
  .tab{ flex:none; font-family:'Poppins',sans-serif; font-size:12px; font-weight:500; padding:9px 14px; border-radius:100px; background:var(--paper); color:var(--maroon); white-space:nowrap; border:1px solid var(--line); text-decoration:none; cursor:pointer; }
  .tab.active{ background:var(--maroon); color:#fff; border-color:var(--maroon); }

  .section-card{ background:var(--paper); margin:16px 16px 0; border-radius:18px; padding:18px 18px 6px; box-shadow:var(--shadow); scroll-margin-top:74px; }
  .section-card.hidden{ display:none; }
  .section-title{ font-family:'Baloo Da 2', sans-serif; font-weight:700; font-size:18px; color:var(--maroon); margin-bottom:12px; display:flex; align-items:center; gap:8px; }
  .item{ display:flex; justify-content:space-between; align-items:center; gap:10px; padding:10px 0; border-bottom:1px solid var(--line); }
  .item.hidden{ display:none; }
  .item-name{ font-weight:500; font-size:14.5px; }
  .item-price{ font-family:'Poppins',sans-serif; font-weight:600; font-size:14px; color:var(--maroon); white-space:nowrap; background:rgba(122,35,35,0.07); padding:3px 9px; border-radius:100px; }

  .pay-grid{ display:flex; gap:8px; margin-top:8px; padding-bottom:14px; }
  .pay-card{ flex:1; background:var(--cream); border:1px solid var(--line); border-radius:12px; padding:12px 6px; text-align:center; cursor:pointer; }
  .pay-card .dot{ width:14px;height:14px;border-radius:50%; margin:0 auto 6px; }
  .pay-card b{ font-size:11.5px; display:block; margin-bottom:3px; }
  .pay-card span{ font-size:10.5px; color:#7a6c60; }
  .pay-hint{ font-size:9.5px; color:#a89a8c; margin-top:6px; text-align:center; }

  .about-p{ font-size:13px; line-height:1.75; margin-bottom:10px; color:#4a3d33; }
  .why-grid{ display:flex; flex-direction:column; gap:7px; padding-bottom:16px; }
  .why-row{ display:flex; align-items:flex-start; gap:8px; font-size:13px; }
  .why-row .tick{ color:var(--teal); font-weight:700; flex:none; }

  footer{ padding:26px 18px 90px; }
  .cta-row{ display:flex; gap:10px; margin-bottom:12px; }
  .cta{ flex:1; font-family:'Poppins',sans-serif; font-size:13px; font-weight:600; text-align:center; padding:13px 8px; border-radius:14px; text-decoration:none; border:none; cursor:pointer; }
  .cta.primary{ background:var(--maroon); color:#fff; }
  .cta.secondary{ background:var(--paper); color:var(--maroon); border:1px solid var(--line); }
  .cta-row2{ display:flex; gap:10px; margin-bottom:16px; }

  .powered{ text-align:center; margin-top:20px; font-family:'Poppins',sans-serif; font-size:10px; color:#a89a8c; line-height:1.7; }
  .powered b{ color:var(--maroon); }

  .fab-col{ position:fixed; right:18px; bottom:22px; display:flex; flex-direction:column; gap:10px; z-index:40; align-items:flex-end; }
  .fab{ width:52px; height:52px; border-radius:50%; display:flex; align-items:center; justify-content:center; font-size:22px; text-decoration:none; box-shadow:0 12px 24px -8px rgba(0,0,0,.35); border:none; cursor:pointer; }
  .fab.call{ background:var(--maroon); color:#fff; }
  .fab.wa{ background:#25D366; color:#fff; }
  .fab.top{ width:40px; height:40px; background:var(--paper); color:var(--maroon); border:1px solid var(--line); font-size:16px; opacity:0; pointer-events:none; transition:opacity .25s ease; }
  .fab.top.show{ opacity:1; pointer-events:auto; }

  .toast{ position:fixed; left:50%; bottom:24px; transform:translateX(-50%) translateY(20px); background:var(--ink); color:#fff; font-family:'Poppins',sans-serif; font-size:12.5px; padding:10px 18px; border-radius:100px; opacity:0; pointer-events:none; transition:opacity .25s ease, transform .25s ease; z-index:50; white-space:nowrap; }
  .toast.show{ opacity:1; transform:translateX(-50%) translateY(0); }
</style>
</head>
<body>

<div id="loadingView" class="loading">
  <div class="spin"></div>
  <div style="font-family:'Poppins',sans-serif; font-size:13px; color:#7a6c60;">লোড হচ্ছে...</div>
</div>

<div id="notFoundView" class="notfound" style="display:none;">
  <h2>😕 পেজ পাওয়া যায়নি</h2>
  <p>এই লিংকে কোনো ব্যবসার পেজ খুঁজে পাওয়া যায়নি।<br>লিংকটা আবার যাচাই করুন।</p>
</div>

<div class="app" id="mainView" style="display:none;">
  <div class="ticker"><div class="ticker-track" id="ticker-track"></div></div>
  <div class="hero">
    <div class="hero-pattern"></div>
    <div class="hero-top">
      <div class="badge-row"><span class="eyebrow" id="hero-eyebrow"></span><span class="status-pill" id="status-pill"></span></div>
      <svg class="wheel" viewBox="0 0 48 48" fill="none"><circle cx="24" cy="24" r="20" stroke="#E0A527" stroke-width="2.5"/><circle cx="24" cy="24" r="4" fill="#E0A527"/><line x1="24" y1="4" x2="24" y2="44" stroke="#E0A527" stroke-width="2"/><line x1="4" y1="24" x2="44" y2="24" stroke="#E0A527" stroke-width="2"/><line x1="9.5" y1="9.5" x2="38.5" y2="38.5" stroke="#E0A527" stroke-width="2"/><line x1="38.5" y1="9.5" x2="9.5" y2="38.5" stroke="#E0A527" stroke-width="2"/></svg>
    </div>
    <h1 id="hero-name"></h1>
    <div class="tagline" id="hero-tagline"></div>
  </div>
  <div class="info-card" id="info-card"></div>
  <div class="search-wrap"><div class="search-box"><span>🔍</span><input id="search-input" type="text" placeholder="খুঁজুন..."><button class="search-clear" id="search-clear">✕</button></div></div>
  <div class="nav-wrap"><nav class="tabs" id="nav-tabs"></nav></div>
  <div style="height:14px;"></div>
  <div id="sections-root"></div>
  <div class="no-results" id="no-results">😕 কিছু পাওয়া যায়নি</div>
  <footer>
    <div class="cta-row"><a class="cta primary" id="footer-call" href="#">☎️ কল করুন</a><a class="cta secondary" id="footer-whatsapp" href="#">💬 WhatsApp</a></div>
    <div class="cta-row2"><button class="cta secondary" id="footer-share">📤 শেয়ার করুন</button><a class="cta secondary" id="footer-review" href="#" target="_blank" rel="noopener">⭐ রিভিউ দিন</a></div>
    <div class="powered"><b>Powered by Open QR</b><br>Smart Digital Business Profile</div>
  </footer>
</div>

<div class="fab-col" id="fabCol" style="display:none;">
  <button class="fab top" id="fab-top" aria-label="উপরে যান">↑</button>
  <a class="fab wa" id="fab-wa" href="#" target="_blank" rel="noopener" aria-label="WhatsApp">💬</a>
  <a class="fab call" id="fab-call" href="#" aria-label="কল করুন">📞</a>
</div>

<div class="toast" id="toast"></div>

<script src="https://www.gstatic.com/firebasejs/10.12.2/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.12.2/firebase-firestore-compat.js"></script>
<script>
const firebaseConfig = {
  apiKey: "AIzaSyCucH3NfX2nq092ZgRiCwJXtdRz_cjft8I",
  authDomain: "open-qr-bd.firebaseapp.com",
  projectId: "open-qr-bd",
  storageBucket: "open-qr-bd.firebasestorage.app",
  messagingSenderId: "254895573910",
  appId: "1:254895573910:web:da5dd36a46d0fabbc6abb7"
};
firebase.initializeApp(firebaseConfig);
const db = firebase.firestore();

function waLink(n,m){ return "https://wa.me/" + n + "?text=" + encodeURIComponent(m); }
function showToast(m){ const t=document.getElementById('toast'); t.textContent=m; t.classList.add('show'); clearTimeout(showToast._t); showToast._t=setTimeout(()=>t.classList.remove('show'),1800); }
function copyText(t){
  if(navigator.clipboard && window.isSecureContext){ navigator.clipboard.writeText(t).then(()=>showToast("কপি হয়েছে: "+t)); }
  else{ const ta=document.createElement('textarea'); ta.value=t; document.body.appendChild(ta); ta.select(); try{document.execCommand('copy'); showToast("কপি হয়েছে: "+t);}catch(e){showToast(t);} document.body.removeChild(ta); }
}
function isOpenNow(sch){
  if(!sch) return true;
  const now=new Date(); const day=now.getDay(); const mins=now.getHours()*60+now.getMinutes();
  const openMins=(sch.openHour||9)*60+(sch.openMinute||0); const closeMins=(sch.closeHour||21)*60+(sch.closeMinute||0);
  if(Number(sch.closedWeekday)===day) return false;
  return mins>=openMins && mins<closeMins;
}

function renderSection(sec){
  const wrap=document.createElement('section'); wrap.className='section-card reveal'; wrap.id=sec.id;
  if(sec.type==='list'){
    wrap.innerHTML=`<div class="section-title">${sec.icon||'🍽️'} ${sec.title}</div>`+
      (sec.items||[]).map(it=>`<div class="item" data-name="${(it[0]||'').toLowerCase()}"><span class="item-name">${it[0]}</span><span class="item-price">৳ ${it[1]}</span></div>`).join('');
  }
  if(sec.type==='payment'){
    wrap.innerHTML=`<div class="section-title">${sec.icon||'💳'} ${sec.title}</div><div class="about-p" style="margin-bottom:2px;">${sec.text||''}</div><div class="pay-grid">${(sec.payments||[]).map(p=>`<div class="pay-card" data-number="${p.number}"><div class="dot" style="background:${p.color};"></div><b>${p.name}</b><span>${p.number}</span></div>`).join('')}</div><div class="pay-hint">নম্বরে ট্যাপ করলে কপি হয়ে যাবে</div>`;
  }
  if(sec.type==='about'){
    wrap.innerHTML=`<div class="section-title">${sec.icon||'🏪'} ${sec.title}</div>${(sec.paragraphs||[]).map(p=>`<div class="about-p">${p}</div>`).join('')}<div style="font-family:'Baloo Da 2',sans-serif;font-weight:700;font-size:15px;color:var(--maroon);margin:14px 0 8px;">⭐ কেন আমাদের বেছে নেবেন?</div><div class="why-grid">${(sec.whyUs||[]).map(w=>`<div class="why-row"><span class="tick">✓</span>${w}</div>`).join('')}</div>`;
  }
  return wrap;
}

function renderPage(data){
  document.getElementById('loadingView').style.display='none';
  document.getElementById('mainView').style.display='block';
  document.getElementById('fabCol').style.display='flex';
  document.title = (data.name||'Open QR') + ' — মেনু';

  const tickerTrack=document.getElementById('ticker-track');
  const tArr = (data.ticker && data.ticker.length) ? data.ticker : ['🔥 ' + (data.tagline||'')];
  const tHtml = tArr.map(t=>`<span>${t}</span>`).join('');
  tickerTrack.innerHTML = tHtml + tHtml;

  document.getElementById('hero-eyebrow').textContent = data.eyebrow || '';
  document.getElementById('hero-name').textContent = data.name || '';
  document.getElementById('hero-tagline').textContent = data.tagline || '';

  const open = isOpenNow(data.schedule);
  const pill = document.getElementById('status-pill');
  pill.className = 'status-pill ' + (open?'open':'closed');
  pill.innerHTML = `<span class="status-dot"></span>${open?'এখন খোলা':'এখন বন্ধ'}`;

  const phoneTel = data.phoneTel || ('+880' + String(data.phone||'').replace(/^0/,''));
  const whatsapp = data.whatsapp || ('880' + String(data.phone||'').replace(/^0/,''));
  const waMsg = data.whatsappOrderMsg || 'আসসালামু আলাইকুম, আমি জানতে চাই।';

  document.getElementById('info-card').innerHTML = `
    <a href="tel:${phoneTel}"><span class="ic">📞</span>কল করুন</a>
    <a href="${waLink(whatsapp, waMsg)}" target="_blank" rel="noopener"><span class="ic">💬</span>WhatsApp</a>
    <a href="${data.mapsUrl||'#'}" target="_blank" rel="noopener"><span class="ic">📍</span>লোকেশন</a>
    <a href="${data.reviewUrl||'#'}" target="_blank" rel="noopener"><span class="ic">⭐</span>রিভিউ দিন</a>
  `;

  const sections = (data.sections || []).slice();
  if(data.payments && data.payments.length){
    sections.push({ id:'sec-payment', icon:'💳', title:'বিল পরিশোধ করুন', type:'payment', text:'আপনার সুবিধামতো নিচের যেকোনো মাধ্যমে নিরাপদে বিল পরিশোধ করুন।', payments:data.payments });
  }
  if(data.aboutText || (data.whyUs && data.whyUs.length)){
    sections.push({ id:'sec-about', icon:'🏪', title:'আমাদের সম্পর্কে', type:'about', paragraphs:[data.aboutText||''], whyUs:data.whyUs||[] });
  }

  const nav=document.getElementById('nav-tabs'); const root=document.getElementById('sections-root');
  sections.forEach(sec=>{
    const a=document.createElement('a'); a.className='tab'; a.href='#'+sec.id; a.dataset.target=sec.id;
    a.textContent=(sec.icon||'') + ' ' + sec.title;
    nav.appendChild(a);
    root.appendChild(renderSection(sec));
  });

  document.getElementById('footer-call').href='tel:'+phoneTel;
  document.getElementById('footer-whatsapp').href=waLink(whatsapp, waMsg);
  document.getElementById('footer-whatsapp').target='_blank';
  document.getElementById('footer-review').href=data.reviewUrl||'#';
  document.getElementById('fab-call').href='tel:'+phoneTel;
  document.getElementById('fab-wa').href=waLink(whatsapp, waMsg);

  document.getElementById('footer-share').addEventListener('click', () => {
    const url = window.location.href;
    if(navigator.share){ navigator.share({title:data.name, text:data.tagline, url}).catch(()=>{}); }
    else{ copyText(url); }
  });

  root.addEventListener('click', (e) => {
    const card = e.target.closest('.pay-card');
    if(card) copyText(card.dataset.number);
  });

  const searchInput=document.getElementById('search-input'); const searchClear=document.getElementById('search-clear'); const noResults=document.getElementById('no-results');
  const listSections=Array.from(document.querySelectorAll('.section-card')).filter(s=>s.querySelector('.item'));
  function runFilter(){
    const q=searchInput.value.trim().toLowerCase(); searchClear.classList.toggle('show', q.length>0);
    if(!q){ document.querySelectorAll('.item.hidden').forEach(i=>i.classList.remove('hidden')); listSections.forEach(s=>s.classList.remove('hidden')); noResults.classList.remove('show'); return; }
    let any=false;
    listSections.forEach(sec=>{ let match=false; sec.querySelectorAll('.item').forEach(item=>{ const m=item.dataset.name.includes(q); item.classList.toggle('hidden',!m); if(m){match=true; any=true;} }); sec.classList.toggle('hidden', !match); });
    noResults.classList.toggle('show', !any);
  }
  searchInput.addEventListener('input', runFilter);
  searchClear.addEventListener('click', ()=>{ searchInput.value=''; runFilter(); });

  const tabs=Array.from(document.querySelectorAll('.tab'));
  function setActive(id){ tabs.forEach(t=>t.classList.toggle('active', t.dataset.target===id)); }
  tabs.forEach(tab=>{ tab.addEventListener('click', (e)=>{ e.preventDefault(); const id=tab.dataset.target; const target=document.getElementById(id); if(target){ target.scrollIntoView({behavior:'smooth', block:'start'}); setActive(id); } }); });
  if(tabs.length) setActive(tabs[0].dataset.target);

  const revealObserver=new IntersectionObserver((entries)=>{ entries.forEach(e=>{ if(e.isIntersecting){ e.target.classList.add('in'); revealObserver.unobserve(e.target); } }); }, {threshold:0.1});
  document.querySelectorAll('.reveal').forEach(el=>revealObserver.observe(el));

  const fabTop=document.getElementById('fab-top');
  window.addEventListener('scroll', ()=>{ fabTop.classList.toggle('show', window.scrollY>500); });
  fabTop.addEventListener('click', ()=>window.scrollTo({top:0, behavior:'smooth'}));
}

function showNotFound(){
  document.getElementById('loadingView').style.display='none';
  document.getElementById('notFoundView').style.display='flex';
}

const parts = window.location.pathname.split('/').filter(Boolean);
const slug = parts[0];

if(!slug){
  showNotFound();
} else {
  db.collection('clients').doc(slug).get().then(doc => {
    if(doc.exists){ renderPage(doc.data()); }
    else{ showNotFound(); }
  }).catch(err => { console.error(err); showNotFound(); });
}
</script>
</body>
</html>
