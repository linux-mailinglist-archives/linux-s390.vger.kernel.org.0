Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8546506ABD
	for <lists+linux-s390@lfdr.de>; Tue, 19 Apr 2022 13:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351540AbiDSLiI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 19 Apr 2022 07:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351483AbiDSLhq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Apr 2022 07:37:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2D13F8C
        for <linux-s390@vger.kernel.org>; Tue, 19 Apr 2022 04:35:03 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id t11so32219309eju.13
        for <linux-s390@vger.kernel.org>; Tue, 19 Apr 2022 04:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KCOFhD4+rlVNZRDw2Wohm1cF4JuH6iXwMNcg8BbQ2EU=;
        b=AYH2hChvUIAZzE5RbrvoO27rgVFPlPgb3N7BdmuGnv+dXGQObVH8yVqymZuILpzO7Y
         bkDoMy1A7h8GAPQurW62zwXow+AozGNnbwzPotN5lL7nJ9doCOcW+XeLkfJptmzu7YgD
         zbxheimturxJlu/l0jyWKS3bNOrwNKWep1odA0rMJ3SVftjqaHSNYz138OFhZehV5LB0
         3OGVzXJiirBRAXeY62ufi6Mz148sg5ejozM8ZsRp1Yzb4XIc0H5QcBGK206K80tjEDdr
         GIRJIkeFxhn4JuGEn9auK3iyW3gL9phUwZTqkAxjyWQzPk1MJj6rUPzVHx+JQ0Dc6gJ5
         wgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KCOFhD4+rlVNZRDw2Wohm1cF4JuH6iXwMNcg8BbQ2EU=;
        b=Jo1+kxMzNbxKPahx4nDUZruER/hlrBj4oJ7YQzX2PIIoT0ndITSIh7sQPZWZkQsqZ4
         RhLDnoz/S/FxAFUj0OyfvfUAZnELIJeeXTEXvw1O3i6bP3pinN10VIqhbpA6cPYXGV+n
         nI1XbAjJ/1YNVtYZFdQTx70cnbRDrvsQnOx9+pxSVZ8RwEwDAPQSK/uGYBPHrrOSFwxG
         uU7ZzkDi1woY89EmzcWPZE3YM9EqYvzBQ9vPD0aflLZ/VQ1lmn+zjw5w+0quUP3jFQe2
         OKK9JI31ziQ0Y8n8TBTA3RWKJeKPRKHkASqZK7YVLXwmY3kYtH9Ev4VSvVljveo6WicI
         5OMA==
X-Gm-Message-State: AOAM531fOhH8dtAeKVHuK+ALPhrxs5H3shWba5PLxDwrqQ3sXe5OlkXD
        SdlmKuyYtCvWJhJwYD8mje+K1w==
X-Google-Smtp-Source: ABdhPJw6wuVTlMl7cBqDd3vRX3OHQB0VzWpmNYx+bcp3YaVGC5PiJJHzMz42CL0W7WUhn1V2riWvyQ==
X-Received: by 2002:a17:907:3e9b:b0:6e7:f58a:9b91 with SMTP id hs27-20020a1709073e9b00b006e7f58a9b91mr1179180ejc.291.1650368101608;
        Tue, 19 Apr 2022 04:35:01 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b006e89869cbf9sm5608802ejb.105.2022.04.19.04.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:35:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v7 09/12] clk: imx: scu: Fix kfree() of static memory on setting driver_override
Date:   Tue, 19 Apr 2022 13:34:32 +0200
Message-Id: <20220419113435.246203-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The driver_override field from platform driver should not be initialized
from static memory (string literal) because the core later kfree() it,
for example when driver_override is set via sysfs.

Use dedicated helper to set driver_override properly.

Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/imx/clk-scu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index ed3c01d2e8ae..4996f1d94657 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -683,7 +683,12 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 		return ERR_PTR(ret);
 	}
 
-	pdev->driver_override = "imx-scu-clk";
+	ret = driver_set_override(&pdev->dev, &pdev->driver_override,
+				  "imx-scu-clk", strlen("imx-scu-clk"));
+	if (ret) {
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
 
 	ret = imx_clk_scu_attach_pd(&pdev->dev, rsrc_id);
 	if (ret)
-- 
2.32.0

