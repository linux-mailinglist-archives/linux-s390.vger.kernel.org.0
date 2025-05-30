Return-Path: <linux-s390+bounces-10872-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5BAC8409
	for <lists+linux-s390@lfdr.de>; Fri, 30 May 2025 00:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E933BB1E9
	for <lists+linux-s390@lfdr.de>; Thu, 29 May 2025 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D684421D5B5;
	Thu, 29 May 2025 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0fS9Ld5"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729621FF2E
	for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748557192; cv=none; b=i/+BmAw3ax4I3xnjl5yHvyuXCRSOTGBBQLThksejhOmY+Dhj6s4jgMQTckOUYgDkvj4SiuDp3ISTkxMBBZOYb50Vi/lZ68UjkOm6cRzjBP6Dca/Cv4AX9X41T7Ttb1LjdUzC/jn6HG7mx0yTobJOf99C9fsKoeACn9KPzq4OPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748557192; c=relaxed/simple;
	bh=kTJU+BCpy+YfnmNVK0XXos503sjQaoFOT3vknQpOyIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eMPF//fJGKu/EYl9+abJg1d4EG3ema0yGBqYanep+97tWgaajJCrsZ7lSwGG872ogC4k2y8pYlTrsiC8pJhC2C4zSPfTgXxsIkAcdQ2ImZVnJyX00yrhygabeEJioxQExuEZt9Uy8xQFJ6rbYzwS0NS75OsYr+a1PtZD1W1UcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0fS9Ld5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b240fdc9c20so1408723a12.3
        for <linux-s390@vger.kernel.org>; Thu, 29 May 2025 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748557191; x=1749161991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Nbpri48BJbTJkPhI+6+t1fCLMj96eqwMn5c+krAapnw=;
        b=J0fS9Ld5qWs0H3IQXzxFzURYmX3S9eVM1OGO6iuzIAfnvh0A/jVP3NprEtDVPvpaj5
         pMCiYKfYWBgCHnlq5lxmYdNyJRjpui/DbqdZM897ThuMm8IFDhJF9eSonRbCvg+1iUUc
         sqAi/yZfKd6AmuCRbNj98a2eL1H0mcd5bAAjszlEOuUBL4PhFH6487Tz+eHfqVAYaLQZ
         Xtm189rBPXOVvJaaZLxOuA44JKiTP2trtJ32muoiU7506SHk/452zgj3yORfoSuD9nHD
         GhhGklYAnUf83z9Ti0eQIxBNouDhk6MHq6NofOYQv03J0pdWP1t25NAPnnwe0SOotwbW
         YfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748557191; x=1749161991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nbpri48BJbTJkPhI+6+t1fCLMj96eqwMn5c+krAapnw=;
        b=LZdxYRIpMaAmCVAyYm4QUGeL2sk6P/Y9KZHcyU/5X+cFDQ3kKuvXhvRTpoKcxfqViv
         63QbO9JYhJ495DxrcmERibyzGnGx+rFU2HQkSnOF6VBjREf7gEl3+/B+g89ZHq+7d2J7
         hJDZkB1XVR68h5NhJ8zDzSukDo801PKqqgUQVBvLXkCmuzMdihkDRhw+QkJADsLs9JUh
         4xXZSC+b79Nxfh6zIIL3p3hfw2pbHh7uRD6eFCthhccafl2M9q9PZKwrXbGdDQxqNnac
         wyvwtS27EQTdL81XGmjo9oKFtH8oXnqOl7NRzNS8TIcHV/qNjGqKybflhEoGQw9gqyRa
         e8yw==
X-Forwarded-Encrypted: i=1; AJvYcCVEl68SzWKnyfZVn1hUV0kFpiKJj0zw0lQnVEodEfgL6OuY1UYEJR8DjDcbIhvGCtP95Xy4R/Dv/vVG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+b9438MpT0lpQBCUNXmqYyGmjZryRJqS4Nr//NTz+drI1VS8
	tRVUUvRfQ/9V3v1FKvuL+t9xlfpU8OiK/XRH28e2MqSN4RIAVBfiwF1yK3wsWDMxcH2XeOMI603
	ST0DuVw==
X-Google-Smtp-Source: AGHT+IHuwZNfPgyrnwyADF8g95T4zavwWZW00oX7NuXupAAgJ0OLZRFru6H+XVBmJZXEVD6LLJdmi6syi64=
X-Received: from pfblt12.prod.google.com ([2002:a05:6a00:744c:b0:740:b0f1:1ede])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:46c4:b0:1f5:7d57:830f
 with SMTP id adf61e73a8af0-21ad978d702mr1874768637.33.1748557190764; Thu, 29
 May 2025 15:19:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 29 May 2025 15:19:19 -0700
In-Reply-To: <20250529221929.3807680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529221929.3807680-7-seanjc@google.com>
Subject: [kvm-unit-tests PATCH 06/16] x86: Add and use X86_PROPERTY_INTEL_PT_NR_RANGES
From: Sean Christopherson <seanjc@google.com>
To: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "=?UTF-8?q?Nico=20B=C3=B6hr?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a definition for X86_PROPERTY_INTEL_PT_NR_RANGES, and use it instead
of open coding equivalent logic in the LA57 testcase that verifies the
canonical address behavior of PT MSRs.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/processor.h | 3 +++
 x86/la57.c          | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index cbfd2ee1..3b02a966 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -370,6 +370,9 @@ struct x86_cpu_property {
 
 #define X86_PROPERTY_XSTATE_TILE_SIZE		X86_CPU_PROPERTY(0xd, 18, EAX,  0, 31)
 #define X86_PROPERTY_XSTATE_TILE_OFFSET		X86_CPU_PROPERTY(0xd, 18, EBX,  0, 31)
+
+#define X86_PROPERTY_INTEL_PT_NR_RANGES		X86_CPU_PROPERTY(0x14, 1, EAX,  0, 2)
+
 #define X86_PROPERTY_AMX_MAX_PALETTE_TABLES	X86_CPU_PROPERTY(0x1d, 0, EAX,  0, 31)
 #define X86_PROPERTY_AMX_TOTAL_TILE_BYTES	X86_CPU_PROPERTY(0x1d, 1, EAX,  0, 15)
 #define X86_PROPERTY_AMX_BYTES_PER_TILE		X86_CPU_PROPERTY(0x1d, 1, EAX, 16, 31)
diff --git a/x86/la57.c b/x86/la57.c
index 41764110..1161a5bf 100644
--- a/x86/la57.c
+++ b/x86/la57.c
@@ -288,7 +288,7 @@ static void __test_canonical_checks(bool force_emulation)
 
 	/* PT filter ranges */
 	if (this_cpu_has(X86_FEATURE_INTEL_PT)) {
-		int n_ranges = cpuid_indexed(0x14, 0x1).a & 0x7;
+		int n_ranges = this_cpu_property(X86_PROPERTY_INTEL_PT_NR_RANGES);
 		int i;
 
 		for (i = 0 ; i < n_ranges ; i++) {
-- 
2.49.0.1204.g71687c7c1d-goog


