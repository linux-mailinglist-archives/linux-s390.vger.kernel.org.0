Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839B95FF1E4
	for <lists+linux-s390@lfdr.de>; Fri, 14 Oct 2022 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJNP6y (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 14 Oct 2022 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJNP6v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Oct 2022 11:58:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083FA122757
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 08:58:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id 13so11479425ejn.3
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFKG/UoJdjvjZL4a++TyBLwRn5J9ab/1o+9LeC1+Wdk=;
        b=TWAL9EKRVGNsLjKjhYh/mC6I8/1d/oatjVnsDN9OWuvFem7UzU02ZKqRzzv3m+6WNJ
         XpbFkMRKHd8kMuyJPFPJ2O4coxdaDl4faAyVqhStpaSUGYq7BHI1TWK1CROOsrCSLceS
         oCa0J4Fufc1QFYIqSNT7YYCBkHCuQagy+1h8ytDYHkttIN15LC4NsO9AFDHEPqj1jTqO
         4aCSqLM2Nu3stjaVcqAwPtMDAHgS/shNxwcrymDs9yg/ism0dyRjPiNJywK3a2Ao/iyX
         qrOsHJe4Ab8pwfjJp7mLQWu47/wJG/qQKDv8bTBXEBTHUkrCbt724EXqhc5mXve0RXVF
         Q5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFKG/UoJdjvjZL4a++TyBLwRn5J9ab/1o+9LeC1+Wdk=;
        b=4Sh5/hC/SSmR8nyEBlL5f5SrmR/q2QN5K/7/Q0uZYcKb/xyvOxx6cJIK7Ll2uRoZ3c
         tz6cfIQ5TpgK7G8cifACQfXLWlYhW4w0JeEnrKiHX/0DsZYBjC5Lj6LHKMMXizzsuJc9
         sY28uDBrQqJab018rA6azP+2mcndse14YPkLW+l1EtSeW9qdNRNXBRRlqIzPAXAC+EDB
         0YVZBq8C91aGCo9vs7eqj4+OXMiKd5aiYkLkWEzJ02sNw1bhWYtyJ/sy8Y5EaXRbuMii
         epjUCqfXlvbWSJxwGfuGN2tOgBXeT8mSVvMe7S49Gm9BrxpQc01MGtISOR476ypKMen8
         QP9Q==
X-Gm-Message-State: ACrzQf0yxMhZdp4qesRRE7lAxdNNnkE3ep5zjRs9T5g1uVGkaQZhzwUN
        DEIBaNMmtbLvwlrUaXbLeD1+Fw==
X-Google-Smtp-Source: AMsMyM7/e9vDSoMxdhGGaaPUCS7n6lh8z7ltnxJPYvupdtdDP7MiBbMySEaXciThld3Qry9um9n4rA==
X-Received: by 2002:a17:906:4783:b0:780:5be5:c81b with SMTP id cw3-20020a170906478300b007805be5c81bmr4152627ejc.76.1665763128360;
        Fri, 14 Oct 2022 08:58:48 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906434f00b007806c1474e1sm1686070ejm.127.2022.10.14.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:58:48 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Anup Patel <anup@brainfault.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] RISC-V: Fix /proc/cpuinfo cpumask warning
Date:   Fri, 14 Oct 2022 17:58:44 +0200
Message-Id: <20221014155845.1986223-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221014155845.1986223-1-ajones@ventanamicro.com>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
start and next seq operations implement a pattern like

  n = cpumask_next(n - 1, mask);
  show(n);
  while (1) {
      ++n;
      n = cpumask_next(n - 1, mask);
      if (n >= nr_cpu_ids)
          break;
      show(n);
  }

which will issue the warning when reading /proc/cpuinfo. Ensure no
warning is generated by validating the cpu index before calling
cpumask_next().

[*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Cc: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 4d0dece5996c..5aa0ae8dd115 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -166,6 +166,9 @@ static void print_mmu(struct seq_file *f)
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
+	if (*pos == nr_cpu_ids)
+		return NULL;
+
 	*pos = cpumask_next(*pos - 1, cpu_online_mask);
 	if ((*pos) < nr_cpu_ids)
 		return (void *)(uintptr_t)(1 + *pos);
-- 
2.37.3

