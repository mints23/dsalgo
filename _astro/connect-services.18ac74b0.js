const i={badge:"Next batch",cardHint:"Join the next batch",cta:"Add me to batch →",signInCta:"Sign in to join batch →",modalLead:"Small live batches — patterns, live coding, and what interviewers actually test. Add yourself and we’ll email when the next batch opens.",success:"You're on the batch list. We'll email you when the next DSA Classes batch opens.",priceSuffix:"next batch"},t=[{id:"system-design",title:"System Design",benefit:"Think like a senior engineer",hook:"Trade-offs, scale narratives, and interview-ready design stories.",icon:"🏗️",subject:"Connect — System Design",accent:"#0f766e",price:"₹799",pricePeriod:"· 1 session",sessionPricePaise:79900,mailBody:`Hi,

I need help with: System Design

My goal:
Current level:
Timeline:

Thanks!`},{id:"dsa-classes",title:"DSA Classes",benefit:"Learn patterns live",hook:"Topic-focused sessions — when to use it, how to code it, and what interviewers actually test.",icon:"📚",subject:"Connect — DSA Classes",accent:"#6d28d9",price:"₹499",pricePeriod:"· per session",comingSoon:!0,mailBody:`Hi,

I am interested in DSA Classes when they launch.

My level:
Topics I care about:

Thanks!`},{id:"roadmap",title:"Road Map for High CTC",benefit:"Stop guessing what’s next",hook:"Phased plan: what to solve, when, and in what order for top offers.",icon:"🗺️",subject:"Connect — Road Map for High CTC",accent:"#0369a1",price:"₹599",pricePeriod:"· 1 session",sessionPricePaise:59900,mailBody:`Hi,

I need help with: Road Map for High CTC

My goal:
Current level:
Timeline:

Thanks!`},{id:"cv-review",title:"CV Review",benefit:"Get past the resume screen",hook:"Impact bullets, ATS layout, and the story recruiters actually read.",icon:"📄",subject:"Connect — CV Review",accent:"#01696f",price:"₹399",pricePeriod:"· 1 session",sessionPricePaise:39900,mailBody:`Hi,

I need help with: CV Review

My goal:
Current level:
Timeline:

Thanks!`},{id:"mentorship",title:"1:1 Mentorship",benefit:"Ongoing coach in your corner",hook:"Regular check-ins, accountability, and direction across your full prep journey.",icon:"🤝",subject:"Connect — 1:1 Mentorship",accent:"#b45309",price:"₹799",pricePeriod:"· 1 session",sessionPricePaise:79900,mailBody:`Hi,

I need help with: 1:1 Mentorship

My goal:
Current level:
Timeline:

Thanks!`},{id:"motivation",title:"Motivation",benefit:"Stay in the game",hook:"Burnout, consistency, and mindset for a 6–12 month grind.",icon:"🔥",subject:"Connect — Motivation",accent:"#c2410c",price:"₹10",pricePeriod:"· 1 session",sessionPricePaise:1e3,mailBody:`Hi,

I need help with: Motivation

My goal:
Current level:
Timeline:

Thanks!`}];function s(e){if(e.sessionPricePaise!=null)return e.sessionPricePaise;const n=e.price.replace(/,/g,"").match(/₹?\s*(\d+(?:\.\d+)?)/);if(n)return Math.round(parseFloat(n[1])*100)}export{s as a,t as b,i as c};
