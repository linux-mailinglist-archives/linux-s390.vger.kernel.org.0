Return-Path: <linux-s390+bounces-21539-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B4O2FoONR2pqbAAAu9opvQ
	(envelope-from <linux-s390+bounces-21539-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 12:22:59 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14170128D
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 12:22:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=e0Cuc7Jv;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21539-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21539-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFFB1301413F
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jul 2026 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F24E357CE5;
	Fri,  3 Jul 2026 10:19:43 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509603B5E01
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 10:19:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073983; cv=none; b=Sc7iXpMHhvH4FG3P1EBrmmCTLQgiJKm34NiyV1VL7Y7QtQ2NJAxrf+mWaoDFj9DHTzry3aLz+mglZT8ZiALhvbi7H8zWhdWGKN57bxCbV4Xxs3s0HhuRa5gPaqOkJGqrLOTt2qHdikXHIi+0YdTc/kBxrLucPqr6VCUxevaXBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073983; c=relaxed/simple;
	bh=tRqX3R6EiKC5w+Fjl8swgCaFgI3p6H6/SqU24pOE9sM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=FyPvM9hJTTepwdpJw1iT73+SHOVqiVsg1KdlACKw2z4jrJV3c+IvHhsEKm8e8pjNMtOZrf1g6JTFKjZ5M04pgCkpgPLLWH2nnNVWtfPRVRA2RisyBHEfdBu35psld1+I7TMQHhL7Gj72T+8skVe/zzIrtc1L+gkD5/TCzyJutEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e0Cuc7Jv; arc=none smtp.client-ip=91.218.175.189
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783073967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kh3FyxapX81U/ZPkDXPQ35eHo8l1a0EYTCkh/tPyQcQ=;
	b=e0Cuc7JvJVHteKushc+UtNVkwNT9o1lVu5LvqWVmdqPsMSPQgu9A2kRfsnx0xQfRnUHPYp
	E5DoGGsQTiJ/6LeWKpBLgQMBOdLAW9HcOCrzUybirGsEQP8UiAZrRmv4xietGvdTMPXY2X
	gD/tE/T+aE5W3zMioXiLzp1kYJy+Cz0=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 10:19:10 +0000
Message-Id: <DJOUYOKL6N3R.BFIO8HEL03OA@linux.dev>
Subject: Re: [PATCH v12 02/16] set_memory: add
 folio_{zap,restore}_direct_map helpers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
 <kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
 <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>, "loongarch@lists.linux.dev"
 <loongarch@lists.linux.dev>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
 <corbet@lwn.net>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "yuzenghui@huawei.com" <yuzenghui@huawei.com>, "will@kernel.org"
 <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org"
 <willy@infradead.org>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
 "mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org" <ast@kernel.org>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
 <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
 <kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
 "haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
 <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com"
 <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jannh@google.com" <jannh@google.com>, "pfalcato@suse.de"
 <pfalcato@suse.de>, "skhan@linuxfoundation.org"
 <skhan@linuxfoundation.org>, "riel@surriel.com" <riel@surriel.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com"
 <jgross@suse.com>, "yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>, "yosry@kernel.org"
 <yosry@kernel.org>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "tabba@google.com" <tabba@google.com>, "prsampat@amd.com"
 <prsampat@amd.com>, "jthoughton@google.com" <jthoughton@google.com>,
 "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "aou@eecs.berkeley.edu"
 <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org"
 <chenhuacai@kernel.org>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "dev.jain@arm.com" <dev.jain@arm.com>,
 "gor@linux.ibm.com" <gor@linux.ibm.com>, "hca@linux.ibm.com"
 <hca@linux.ibm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pjw@kernel.org" <pjw@kernel.org>, "shijie@os.amperecomputing.com"
 <shijie@os.amperecomputing.com>, "svens@linux.ibm.com"
 <svens@linux.ibm.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com"
 <urezki@gmail.com>, "zhengqi.arch@bytedance.com"
 <zhengqi.arch@bytedance.com>, "gerald.schaefer@linux.ibm.com"
 <gerald.schaefer@linux.ibm.com>, "jiayuan.chen@shopee.com"
 <jiayuan.chen@shopee.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
 "vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
 <jackmanb@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>,
 "Itazuri, Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek"
 <derekmn@amazon.com>
References: <20260410151746.61150-1-kalyazin@amazon.com>
 <20260410151746.61150-3-kalyazin@amazon.com>
In-Reply-To: <20260410151746.61150-3-kalyazin@amazon.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21539-lists,linux-s390=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kalyazin@amazon.co.uk,m:kvm@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:linux-mm@kvack.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel@xen0n.name,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:loongarch@lists.linux.dev,m:linux-pm@vger.kernel.org,m:pbonzini@redhat.com,m:corbet@lwn.net,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:will@kernel.org,m:seanjc@google.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:luto@kernel.org,m:peterz@infradead.org,m:willy@infradead.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:lorenzo.stoakes@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:ast@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.de
 v,m:john.fastabend@gmail.com,m:kpsingh@kernel.org,m:sdf@fomichev.me,m:haoluo@google.com,m:jolsa@kernel.org,m:jgg@ziepe.ca,m:jhubbard@nvidia.com,m:peterx@redhat.com,m:jannh@google.com,m:pfalcato@suse.de,m:skhan@linuxfoundation.org,m:riel@surriel.com,m:ryan.roberts@arm.com,m:jgross@suse.com,m:yu-cheng.yu@intel.com,m:kas@kernel.org,m:coxu@redhat.com,m:ackerleytng@google.com,m:yosry@kernel.org,m:maobibo@loongson.cn,m:tabba@google.com,m:prsampat@amd.com,m:jthoughton@google.com,m:agordeev@linux.ibm.com,m:aou@eecs.berkeley.edu,m:borntraeger@linux.ibm.com,m:chenhuacai@kernel.org,m:baolu.lu@linux.intel.com,m:dev.jain@arm.com,m:gor@linux.ibm.com,m:hca@linux.ibm.com,m:palmer@dabbelt.com,m:pjw@kernel.org,m:shijie@os.amperecomputing.com,m:svens@linux.ibm.com,m:thuth@redhat.com,m:yang@os.amperecomputing.com,m:Liam.Howlett@oracle.com,m:urezki@gmail.com,m:zhengqi.arch@bytedance.com,m:gerald.schaefer@linux.ibm.com,m:jiayuan.chen@shopee.com,m:rafael@kernel.org,m:yangyicong@hisilicon.com,m:vannapurve@
 google.com,m:jackmanb@google.com,m:patrick.roy@linux.dev,m:itazur@amazon.co.uk,m:derekmn@amazon.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[brendan.jackman@linux.dev,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,lwn.net,arm.com,huawei.com,kernel.org,google.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.com,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,linuxfoundation.org,surriel.com,intel.com,loongson.cn,amd.com,linux.ibm.com,eecs.berkeley.edu,dabbelt.com,os.amperecomputing.com,bytedance.com,shopee.com,hisilicon.com,amazon.co.uk,amazon.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[91];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brendan.jackman@linux.dev,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qemu.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA14170128D

On Fri Apr 10, 2026 at 3:18 PM UTC, Nikita Kalyazin wrote:
> From: Nikita Kalyazin <nikita.kalyazin@linux.dev>
>
> Let's provide folio_{zap,restore}_direct_map helpers as preparation for
> supporting removal of the direct map for guest_memfd folios.
> In folio_zap_direct_map(), flush TLB to make sure the data is not
> accessible.  On some architectures, there may be a double TLB flush
> issued because set_direct_map_valid_noflush already performs a flush
> internally.
>
> The new helpers need to be accessible to KVM on architectures that
> support guest_memfd (x86 and arm64).
>
> Direct map removal gives guest_memfd the same protection that
> memfd_secret does, such as hardening against Spectre-like attacks
> through in-kernel gadgets.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Nikita Kalyazin <nikita.kalyazin@linux.dev>
> ---
>  include/linux/set_memory.h | 13 +++++++++++
>  mm/memory.c                | 45 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index 1a2563f525fc..24caea2931f9 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -41,6 +41,15 @@ static inline int set_direct_map_valid_noflush(const v=
oid *addr,
>  	return 0;
>  }
> =20
> +static inline int folio_zap_direct_map(struct folio *folio)
> +{
> +	return 0;
> +}
> +
> +static inline void folio_restore_direct_map(struct folio *folio)
> +{
> +}
> +
>  static inline bool kernel_page_present(struct page *page)
>  {
>  	return true;
> @@ -57,6 +66,10 @@ static inline bool can_set_direct_map(void)
>  }
>  #define can_set_direct_map can_set_direct_map
>  #endif
> +
> +int folio_zap_direct_map(struct folio *folio);
> +void folio_restore_direct_map(struct folio *folio);
> +
>  #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
> =20
>  #ifdef CONFIG_X86_64
> diff --git a/mm/memory.c b/mm/memory.c
> index 2f815a34d924..3b9ada2cc19c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -78,6 +78,7 @@
>  #include <linux/sched/sysctl.h>
>  #include <linux/pgalloc.h>
>  #include <linux/uaccess.h>
> +#include <linux/set_memory.h>
> =20
>  #include <trace/events/kmem.h>
> =20
> @@ -7479,3 +7480,47 @@ void vma_pgtable_walk_end(struct vm_area_struct *v=
ma)
>  	if (is_vm_hugetlb_page(vma))
>  		hugetlb_vma_unlock_read(vma);
>  }
> +
> +#ifdef CONFIG_ARCH_HAS_SET_DIRECT_MAP
> +/**
> + * folio_zap_direct_map - remove a folio from the kernel direct map
> + * @folio: folio to remove from the direct map
> + *
> + * Removes the folio from the kernel direct map and flushes the TLB.  Th=
is may
> + * require splitting huge pages in the direct map, which can fail due to=
 memory
> + * allocation.  So far, only order-0 folios are supported.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int folio_zap_direct_map(struct folio *folio)
> +{
> +	const void *addr =3D folio_address(folio);
> +	int ret;
> +
> +	if (folio_test_large(folio))
> +		return -EINVAL;
> +
> +	ret =3D set_direct_map_valid_noflush(addr, folio_nr_pages(folio), false=
);
> +	flush_tlb_kernel_range((unsigned long)addr,
> +			       (unsigned long)addr + folio_size(folio));
> +
> +	return ret;
> +}

My local Sashiko run pointed out that this is broken for highmem.

There's no highmem for guest_memfd but there is for secretmem.

... but this isn't actually an issue with the patch, it's currently
broken in Linus' master:

Su[   30.071284] ------------[ cut here ]------------
ccessfully allocated and mapped 2097152000 bytes at 0x3a449000
Populating memor[   30.074614] CPA: called for zero pte. vaddr =3D 0 cpa->v=
addr =3D 0
y...
[   30.078636] WARNING: arch/x86/mm/pat/set_memory.c:1840 at __cpa_process_=
fault+0x34d/0x360, CPU#5: allocate_secret/570
[   30.084789] CPU: 5 UID: 0 PID: 570 Comm: allocate_secret Not tainted 7.1=
.0-14063-g4edcdefd4083-dirty #10 PREEMPTLAZY
[   30.090937] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[   30.097543] EIP: __cpa_process_fault+0x34d/0x360
[   30.100514] Code: ff ff 85 c0 0f 89 7d fe ff ff e9 3d fe ff ff 8b 03 8b =
00 c7 04 24 c8 ff 64 c1 89 44 24 08 8b 45 e8 89 44 24 04 e8 53 7a 00 00 <0f=
> 0b c7 45 f0 f2 ff ff ff e9 fc fc ff ff 90 8d 74 26 00 55 25 00
[   30.110829] EAX: 00000000 EBX: f64afe98 ECX: 00000000 EDX: 00000000
[   30.114799] ESI: 00000000 EDI: f64afe98 EBP: f64afe04 ESP: f64afdcc
[   30.118785] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 0001024=
6
[   30.123020] CR0: 80050033 CR2: 46c48ffc CR3: 038c8000 CR4: 00000690
[   30.127010] Call Trace:
[   30.129078]  __change_page_attr_set_clr+0x5e7/0x870
[   30.132275]  ? console_unlock+0x99/0x130
[   30.135069]  ? irq_work_queue+0x36/0x70
[   30.137853]  ? page_address+0xd3/0xf0
[   30.140421]  set_direct_map_invalid_noflush+0x52/0x60
[   30.143782]  secretmem_fault+0x128/0x210
[   30.146560]  __do_fault+0x25/0x90
[   30.149053]  handle_mm_fault+0x6d1/0xcb0
[   30.151759]  exc_page_fault+0x135/0x3b0
[   30.154487]  ? doublefault_shim+0x150/0x150
[   30.157416]  handle_exception+0x130/0x130
[   30.160137] EIP: 0x804d29f
[   30.162307] Code: 89 54 08 e1 89 54 08 e5 89 54 08 e9 89 54 08 ed c3 0f =
b6 44 24 08 89 7c 24 0c 69 c0 01 01 01 01 8b 7c 24 04 f7 c7 0f 00 00 00 <89=
> 44 0f fc 75 0e c1 e9 02 f3 ab 8b 44 24 04 8b 7c 24 0c c3 31 d2
[   30.172936] EAX: 5a5a5a5a EBX: 00000000 ECX: 0c800000 EDX: 3a449000
[   30.176927] ESI: 00000000 EDI: 3a449000 EBP: bfbbae18 ESP: bfbbadac
[   30.180897] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 0001024=
6
[   30.185161]  ? doublefault_shim+0x150/0x150
[   30.187979] ---[ end trace 0000000000000000 ]---
Bus error                  (core dumped) ./allocate_secret_i686 2000M

Fixing this directly in secretmem.c is kinda yucky but if we can just
make folio_zap_direct_map() a NOP for highmem folios it's nice and easy
so I propose to just fix it as a followup to this series.

Alternatively, we maybe should disable secretmem for highmem systems
since it evidently doesn't have any users.

