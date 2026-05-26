Return-Path: <linux-s390+bounces-20065-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALEBL0HCFWoAagcAu9opvQ
	(envelope-from <linux-s390+bounces-20065-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 26 May 2026 17:54:41 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9529C5D9208
	for <lists+linux-s390@lfdr.de>; Tue, 26 May 2026 17:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 438CC32DEC1E
	for <lists+linux-s390@lfdr.de>; Tue, 26 May 2026 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCB832ED5C;
	Tue, 26 May 2026 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIK99qq7"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775A3218BA;
	Tue, 26 May 2026 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808926; cv=none; b=mY5nDqw1QhK4SQtTbHJNtNpsT5z15FRr5wh3TBManWS5VxCVB65PN2ohGqMWBh+gknECS9iGdS6MTC4QdsKfismaghEmJlx4Ge3BtJ0HVRvt489s4Vk7c9Yhh6cjMDgFF9QoKWIDugao1eACwBkphZoK21hAprJTc1kgr+Tnsjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808926; c=relaxed/simple;
	bh=YaVjrXKhfpqvIJygzREE5zKBOLGP3K/KF1IwfTEAxVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsQN5Q22HI8G80vln7a8JczGj53lg8r3l9J3XaccwL2OtlTCcLXdnEv8Zcovf+A0vbXzVVGp5bF23ZGr/cCQFQWoWyYTV/r+v3PQWgiF0wEZYXHonFRAz0Jvsfl+bnitMLWGVKmmCV8m/WobNWf3h5ggtBanntUHtgg50QTuIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIK99qq7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDF91F00ADB;
	Tue, 26 May 2026 15:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808924;
	bh=u8OFyi867RVcm393aEUm2p/F0THxOCKpMTZFIKs3ThQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OIK99qq7mGm6/uSZ+eHln3fzNY6JPAEVlQ3nnw858mrCA1uY4CFuD/IojPhxFfx21
	 FhEngTcDbRhNe5hlJqWoWs+k+i1cMHIxpfTR51aH5YOM1ehAn7wei5zP+Z5oX3tZky
	 ThaNbEaRJ50388+tcpSPRSUuLJGnMrQV2nglYC0DEpbtYdM1syqQFdhnUHC4VM3Sci
	 Qp1Q+GajyU4n86GpHScAIxOozYMXPUbWleEMk+Nr3iaOdeVGTu3uTutrb+yjGhHKUg
	 vcdKVagxsrBj0pgtyg7itD+seO52vdqAHzI31UTmFWhsAjVU4lbXqscDvR7qFSmfvc
	 K6UC9MhGnAmMA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 009E1F4006B;
	Tue, 26 May 2026 11:22:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 11:22:02 -0400
X-ME-Sender: <xms:mboVah2w9lEaFxOroqxXU_KNnqocFV_VnTO4rR9fF5xIrSlQd2ZOKA>
    <xme:mboVarKgqIipTOOi3yttqBIJ6pLju7xTTYlM3sYLaP7gv1jngZnDtPJGpm3ZIfzTb
    XK8hbNfegcxIZMgNIKXTfhcOn0-pkECcsIe0YIVld258Wu9J8VVgA>
X-ME-Received: <xmr:mboVahIe4fOM9Fi2ev2BgHaOJpjiBTJ9W-oxkVwdCxfOmotaYVFQWF9oYjacSCkxOLlCbeIIiq5khHVZWGZMuchdAjiwsZc0>
X-ME-Proxy-Cause: dmFkZTGukvwILOOvmar/YpzpbGxcThya1huxzJh8wPsxZqy8c45YkWNCoU6I+5YwKn52tQ
    FimljOlgnke1vtXjpOlEIIzqmHsNns/ZJmR5LvOMJZ1ZAxr1Wodn13Yfg5DhdKPAFkkKdi
    S/I7TyNwTX0Y8RnSZ8QdIy1Jqo5XXbQ7RrhyzAa5WGdgm6MjwoUKqKh3Uy0nLCbaeSbo/A
    de7q+7hNeF+MaWmtgdzUE1cHx21KJc4LOZtluly95DY4Z5RWj4II3/QyKmUNnRJfzsX0RM
    0qJoKWNtX92mkNHkt//vUyp2c9tsMyTX+3jK+p4XRlCmImR6eKHhgKraqRzLlyyuiALLVF
    BmwxRBcdiXXGd/rKwZCdxOjYe4DdHuprJcaZFYyur4Oa6DX9B54vI15bOHrxdzX0dnvW+T
    GRo//pHEEMeIvgq4AEg0NxreKnw+n2Y7hUVNpDZkFLRIPDrL2HWD5nmdRwJj0mx8r5SCcy
    VlO6wiKRbPz1ZrjyFsUHBf0Xal+J4wMT/fm8RijJFOmPvgenY/oNsV5YF5OXBwNBq4YDhn
    Yu8zfTEjYhTWRCcF3KreCMd0Gc6I+HOTbIDwZpjBCN2CH59GAsfibqyzcMC7+QFiEuIaRF
    lZBD1q4ntZcu5ct4ZZV8TFtP5f0Dh8NyNl8VTOLtBkYg1P5rrowjry+SyTsQ
X-ME-Proxy: <xmx:mboVashQqi27-Lrriw3gH1DYxHufhaLKtJuICpYsJmgkSPH5sIAYPQ>
    <xmx:mboVasSBUSCd9P3bAQ9x8xMkCQhPn9ethhbp-wCT6tGVAijQAs3AWA>
    <xmx:mboVajkdWsI_QDph40EduXPUqXyBSWOXN263xhANj1OlDequ4fwNug>
    <xmx:mboVamYvjSHidQzxsiZeSrKFoqjYllHFyNznG0kptBE4-NhRrL-rEg>
    <xmx:mboVatZMA2CzS2d0vCRDf0F7hq-yF6812QiCpj766_s3oJhgawsatzbd>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:22:01 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,	Arnd Bergmann <arnd@arndb.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lyude Paul <lyude@redhat.com>,	Thomas Huth <thuth@redhat.com>,
	Sohil Mehta <sohil.mehta@intel.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,	linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org,	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v2 04/12] openrisc: Include <linux/cpumask.h> in smp.h
Date: Tue, 26 May 2026 08:21:40 -0700
Message-ID: <20260526152148.30514-5-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260526152148.30514-1-boqun@kernel.org>
References: <20260526152148.30514-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20065-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,iogearbox.net,linux.dev,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,infradead.org,linutronix.de,vger.kernel.org,onurozkan.dev,collabora.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[68];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9529C5D9208
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lyude Paul <lyude@redhat.com>

While OpenRISC currently doesn't fail to build upstream, it appears that
include <asm/smp.h> in the right headers is enough to break that -
primarily because OpenRISC's asm/smp.h header doesn't actually provide any
definition for struct cpumask. Which means the only reason we aren't
failing to build kernel is because we've been lucky enough that every spot
including asm/smp.h already has definitions for struct cpumask pulled in.

This became evident when trying to work on a patch series for adding
ref-counted interrupt enable/disables to the kernel, where introducing a
new interrupt_rc.h header suddenly introduced a build error on OpenRISC:

     In file included from include/linux/interrupt_rc.h:17,
                      from include/linux/spinlock.h:60,
                      from include/linux/mmzone.h:8,
                      from include/linux/gfp.h:7,
                      from include/linux/mm.h:7,
                      from arch/openrisc/include/asm/pgalloc.h:20,
                      from arch/openrisc/include/asm/io.h:18,
                      from include/linux/io.h:12,
                      from drivers/irqchip/irq-ompic.c:61:
     arch/openrisc/include/asm/smp.h:21:59: warning: 'struct cpumask'
     declared inside parameter list will not be visible outside of this
     definition or declaration
        21 | extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
           |                                                           ^~~~~~~
     arch/openrisc/include/asm/smp.h:23:54: warning: 'struct cpumask'
     declared inside parameter list will not be visible outside of this
     definition or declaration
        23 | extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
           |                                                      ^~~~~~~
     drivers/irqchip/irq-ompic.c: In function 'ompic_of_init':
  >> drivers/irqchip/irq-ompic.c:191:28: error: passing argument 1 of
     'set_smp_cross_call' from incompatible pointer type
     [-Werror=incompatible-pointer-types]
       191 |         set_smp_cross_call(ompic_raise_softirq);
           |                            ^~~~~~~~~~~~~~~~~~~
           |                            |
           |                            void (*)(const struct cpumask *, unsigned int)
     arch/openrisc/include/asm/smp.h:23:32: note: expected 'void (*)(const
     struct cpumask *, unsigned int)' but argument is of type 'void
     (*)(const struct cpumask *, unsigned int)'
        23 | extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));

To fix this, let's take an example from the smp.h headers of other
architectures (x86, hexagon, arm64, probably more): just include
linux/cpumask.h at the top.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-5-lyude@redhat.com
---
 arch/openrisc/include/asm/smp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/openrisc/include/asm/smp.h b/arch/openrisc/include/asm/smp.h
index 007296f160ef..84653aaffa96 100644
--- a/arch/openrisc/include/asm/smp.h
+++ b/arch/openrisc/include/asm/smp.h
@@ -9,6 +9,8 @@
 #ifndef __ASM_OPENRISC_SMP_H
 #define __ASM_OPENRISC_SMP_H
 
+#include <linux/cpumask.h>
+
 #include <asm/spr.h>
 #include <asm/spr_defs.h>
 
-- 
2.50.1 (Apple Git-155)


