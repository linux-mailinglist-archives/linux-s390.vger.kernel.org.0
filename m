Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AFA524654
	for <lists+linux-s390@lfdr.de>; Thu, 12 May 2022 09:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350642AbiELHBw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 12 May 2022 03:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350654AbiELHBp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 May 2022 03:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1506C4A3FF
        for <linux-s390@vger.kernel.org>; Thu, 12 May 2022 00:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652338900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=iL08WrcDmWnPSBuKr8caEa5TegpmPAWZ3ptXRRWyehnefQCwOm5xml6gQ0gFEKQhacTJQN
        1EoENhwrVx+Q2XcgK+UWaJtSdtf+CAWLMKaNRAFY/UqStcfUdoW3cHkww158qdPJevjmfY
        P3oa1hTmMsHSlQ4LGvajfChKrC2FBUo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-t9-OxL_eOIWanfSWtj_6zg-1; Thu, 12 May 2022 03:01:39 -0400
X-MC-Unique: t9-OxL_eOIWanfSWtj_6zg-1
Received: by mail-pg1-f197.google.com with SMTP id q143-20020a632a95000000b003c1c3490dfbso2189845pgq.20
        for <linux-s390@vger.kernel.org>; Thu, 12 May 2022 00:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sd8cjBSOdeaVjyH4f3lxl+0xYw15nzSjwpJw6bzSgLk=;
        b=rL7C6WtT/NtFrx8cYgbrVN/PMNkiTflryFzvkIYWzX9EhSejxLjZOjstgQeeFqm2ka
         DxiV7pglFbMYT8r8xhV4k3BaW/MFOl68DvA7GNDmIg9NJ0HsO6txeHVOazzkddSzkxhn
         iS0PSDM34FhftaAelCAJj4eOg+lY8V/dIrkVsRWcFTpQLS/cqEhgZb2VBYiaeia4C7gw
         S+Mj5V6r0iJw+5lcOZu+zjYIes7Qq9xV0VIWgAsYZECNloGRJFABM8a8knqHYYZaSotj
         OXotW7GwhUUWGOA4bXoI500XBOHG7HnO/Aaapityz2Re79NCfr2L7h067yaddMu+PEZ+
         IFhA==
X-Gm-Message-State: AOAM530NTE2MP3BH5umsU8zyZYzd9P26yxEFa0S2QFdXLgJSE76XFD4c
        J8Up+usMFTKC//o3z9mxBawT+14nyQ2FhW38Cu0p3dcQcu7raIGkSFei6HieW4wOWT8NhbpraRX
        pNlGZnid3sh3hm37yN4JN0A==
X-Received: by 2002:a63:db17:0:b0:3c1:dc15:7a6e with SMTP id e23-20020a63db17000000b003c1dc157a6emr24702562pgg.107.1652338898845;
        Thu, 12 May 2022 00:01:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5+8KvrmgP6uU2JLw0pBjP/QRQb39IFWj7HXL3olAtsPY86WH+mgk5ysySAIY64jPtk9fAOQ==
X-Received: by 2002:a63:db17:0:b0:3c1:dc15:7a6e with SMTP id e23-20020a63db17000000b003c1dc157a6emr24702527pgg.107.1652338898566;
        Thu, 12 May 2022 00:01:38 -0700 (PDT)
Received: from localhost ([240e:3a1:2e9:efa0:e73c:e550:ac9e:58fd])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902a3c900b0015e8d4eb22fsm3060866plb.121.2022.05.12.00.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:01:38 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        stable@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390@vger.kernel.org (open list:S390),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 4/4] kexec, KEYS, s390: Make use of built-in and secondary keyring for signature verification
Date:   Thu, 12 May 2022 15:01:23 +0800
Message-Id: <20220512070123.29486-5-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512070123.29486-1-coxu@redhat.com>
References: <20220512070123.29486-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Michal Suchanek <msuchanek@suse.de>

commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
adds support for KEXEC_SIG verification with keys from platform keyring
but the built-in keys and secondary keyring are not used.

Add support for the built-in keys and secondary keyring as x86 does.

Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
Cc: stable@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8f43575a4dd3..fc6d5f58debe 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -31,6 +31,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 	const unsigned long marker_len = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature *ms;
 	unsigned long sig_len;
+	int ret;
 
 	/* Skip signature verification when not secure IPLed. */
 	if (!ipl_secure_flag)
@@ -65,11 +66,18 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 		return -EBADMSG;
 	}
 
-	return verify_pkcs7_signature(kernel, kernel_len,
-				      kernel + kernel_len, sig_len,
-				      VERIFY_USE_PLATFORM_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
+	ret = verify_pkcs7_signature(kernel, kernel_len,
+				     kernel + kernel_len, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_MODULE_SIGNATURE,
+				     NULL, NULL);
+	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING))
+		ret = verify_pkcs7_signature(kernel, kernel_len,
+					     kernel + kernel_len, sig_len,
+					     VERIFY_USE_PLATFORM_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
+	return ret;
 }
 #endif /* CONFIG_KEXEC_SIG */
 
-- 
2.35.3

