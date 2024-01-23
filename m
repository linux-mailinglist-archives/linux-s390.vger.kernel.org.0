Return-Path: <linux-s390+bounces-1088-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85283879E
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jan 2024 07:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9249DB20B1B
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jan 2024 06:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FDD50263;
	Tue, 23 Jan 2024 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUY9Yx2c"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5675025F
	for <linux-s390@vger.kernel.org>; Tue, 23 Jan 2024 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705992191; cv=none; b=jW4sURMYHpjBJQUs9nb4ZeJbeCAROWsCemIeNdTsuCIvpfT2Amup4c0h+01GQW0SCz/r+xHv6OZ1oIMgSwrEIFvFtEQ3XUdKAEVnh5iBJUEqmuceSM6gVtAT5a+tFw8l2wC9YhwwFjsAzW+1YtA9HKEzpebLWV61soqUxhdYtsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705992191; c=relaxed/simple;
	bh=Q0R2FUM/vqe/upMMhRgpiOo7u30kkYDKFKTZ4CE94Rg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kht63L4XVOdbqnLBv4ag4wWAmuBA5/Qb8Zu0ElaXRY1m+NJ0ClEOqpO22uc8TQZp4JD2yiYheGq6QIicTsJFs6fuR0fY5kopXouwsvatT1RUx+05LvLkjKWZVk5zldm7sBxxLGE6zqcoVTWSmm1EV5gH7Ij8ZHxZrcTi939R0WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUY9Yx2c; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ff93902762so61557457b3.2
        for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 22:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705992189; x=1706596989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2FZwZ+rXghzrwMAzRL81BGjWf4dIgKukf4yDKbJi/Es=;
        b=LUY9Yx2cU7QNPGdyE6OduYogspnbpDHjpIAybc/LO/XQSkEoiJ1GXc/0j9JvMNEhrO
         4c1FUl+ODp0RQ3fn4fqRERPQM4cmiANEtIT5YQ0o5xtkGdJfyUAtbPDAuPh9B8uZrEYk
         DdrCFAkRr8E3S9ntipLYAFOrzEYvwUHMofdRNzzE7bWiZEz6I4yEvoc3eyDCLHybOE+p
         rRonjN2rmC3+YWCxZEZHnvfGUokluPNUxUnQF7Sp1cbdEFMmUODajpQ88AIGy45v11IV
         BTE58cbDg5Rm+fFADuJpGP8Hz9b+uf4u3tONUFhg//o1Wy7x88eRwELQwBt0iiqGSx2g
         XH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705992189; x=1706596989;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2FZwZ+rXghzrwMAzRL81BGjWf4dIgKukf4yDKbJi/Es=;
        b=XoKNKNUdhQSrHyE2FFonTctuNgaA+GDBKIiSWdMB5lEa5njuPbH6UwHmPyU+H2Iat3
         LkBqwhlo3xSuDVkffAOlUbnY03MgBX682u5tEwiSb7r1MAW7cNfAHVXX9CDXLTX0GxQh
         TZIjpo1lsOeEpRW0UOSnnLxIDcwnSJDoiZEXdTEAf0Tmvwlvo3zKhQuLaALOJJJp2tHl
         +wJ1OEkr3sDVzSxeFEYLtq9VWrlzO25r+7yOcXYR2tdEPGtoMiX3JGxvILBqR25Cv76M
         luPSdEdDbGWDMkNSj32SXYwOwb9x+cUG9EPkHpu/esk3+x8/ggIPg9fx0XZCNAWyRa2V
         fPKw==
X-Gm-Message-State: AOJu0YzKVRPenj0xGXvatbpXlZ+cW32e1daezDyLRyDcpeN1eWtHFlZF
	E9HuWhJSuKJDSmKs8DDXoYrm/46cH4t3+yVLM/Oxjj5PpS9A4R/0EhDqRJwAtoQWPkcJ40F1tgE
	JKg==
X-Google-Smtp-Source: AGHT+IEO6A9zRBfOAVXliXkQQKxCV0qhRt+egkKWA991dYf7yzqjSRjLplw2MTnE92/ZhwSFnAUoRNjPv64=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6bca:2511:6f80:6efe])
 (user=surenb job=sendgmr) by 2002:a0d:d68f:0:b0:5f9:990d:78c0 with SMTP id
 y137-20020a0dd68f000000b005f9990d78c0mr2517316ywd.4.1705992189291; Mon, 22
 Jan 2024 22:43:09 -0800 (PST)
Date: Mon, 22 Jan 2024 22:43:05 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123064305.2829244-1-surenb@google.com>
Subject: [PATCH 1/1] arch/arm/mm: fix major fault accounting when retrying
 under per-VMA lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, will@kernel.org, catalin.marinas@arm.com, 
	palmer@dabbelt.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu, 
	agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, 
	surenb@google.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"

The change [1] missed ARM architecture when fixing major fault accounting
for page fault retry under per-VMA lock. Add missing code to fix ARM
architecture fault accounting.

[1] 46e714c729c8 ("arch/mm/fault: fix major fault accounting when retrying under per-VMA lock")

Fixes: 12214eba1992 ("mm: handle read faults under the VMA lock")

Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index e96fb40b9cc3..07565b593ed6 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -298,6 +298,8 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		goto done;
 	}
 	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+	if (fault & VM_FAULT_MAJOR)
+		flags |= FAULT_FLAG_TRIED;
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
-- 
2.43.0.429.g432eaa2c6b-goog


