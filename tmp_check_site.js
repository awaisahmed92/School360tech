const { chromium } = require('playwright');
(async () => {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext();
  const page = await context.newPage();

  page.on('console', msg => {
    console.log(`[console:${msg.type()}] ${msg.text()}`);
  });
  page.on('pageerror', err => {
    console.log(`[pageerror] ${err && err.stack ? err.stack : err}`);
  });
  page.on('requestfailed', req => {
    console.log(`[requestfailed] ${req.url()} :: ${req.failure()?.errorText}`);
  });

  const resp = await page.goto('https://school360techx.com/', { waitUntil: 'networkidle', timeout: 120000 });
  console.log(`status=${resp.status()}`);
  await page.waitForTimeout(5000);
  const html = await page.content();
  console.log(`html_length=${html.length}`);
  await page.screenshot({ path: 'C:/wamp64/www/360tech/School360tech/playwright-shot.png', fullPage: true });
  await browser.close();
})();
