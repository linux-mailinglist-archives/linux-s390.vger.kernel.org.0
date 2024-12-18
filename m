Return-Path: <linux-s390+bounces-7760-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D829F5F5A
	for <lists+linux-s390@lfdr.de>; Wed, 18 Dec 2024 08:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C2A1888D29
	for <lists+linux-s390@lfdr.de>; Wed, 18 Dec 2024 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9DB156F30;
	Wed, 18 Dec 2024 07:32:20 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40341553A3;
	Wed, 18 Dec 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734507140; cv=none; b=DApN6P5WUTl0gSBR1FMDPG4NjO8jOcQr127gbBuMl8E7rZNZLCEdW8iVqZyvjbmcHcx3OsT+ztok9BmkbwEbFyW5XkV3PMaQQBQk1DQYue0qlP6mdI49oIsH5zpnlnOF4bDNaEbEeebK1tNqs2BeV5kxcqhJ0JBWvSDUrbqqE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734507140; c=relaxed/simple;
	bh=puOB+BesLe0CEDIPlwuZFOK+ZLKAQJrXndPvS6Ypyb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLS3RyB0zGGVk5CEX2Qeza8LK46fgzIFGpm4HGh/Ul05by4lbMZ2wnorLVx08N7qoSxbkd1C56DDcTU+LgG2pm6BWpl0xJUQdLzkY7ECHRDKr5+31URjipAlCcb3cbZzxLiUPGJ0rNV3kwcNf3odO3oxZP59psIMZUu02IaapZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YClkR6DjGz9sRr;
	Wed, 18 Dec 2024 08:32:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w2Sln2Ud2ryW; Wed, 18 Dec 2024 08:32:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YClkR4pXrz9sRk;
	Wed, 18 Dec 2024 08:32:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E3478B770;
	Wed, 18 Dec 2024 08:32:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 9Z-UnX9w7GHQ; Wed, 18 Dec 2024 08:32:15 +0100 (CET)
Received: from [10.25.209.139] (unknown [10.25.209.139])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 17B598B763;
	Wed, 18 Dec 2024 08:32:15 +0100 (CET)
Message-ID: <3b44defd-cd2a-4a3c-b72d-bcc0530336da@csgroup.eu>
Date: Wed, 18 Dec 2024 08:32:14 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] vdso: Add generic time data storage
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
 <20241216-vdso-store-rng-v1-3-f7aed1bdb3b2@linutronix.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241216-vdso-store-rng-v1-3-f7aed1bdb3b2@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/12/2024 à 15:09, Thomas Weißschuh a écrit :
> Historically each architecture defined their own way to store the vDSO
> data page. Add a generic mechanism to provide storage for that page.
> 
> Furthermore this generic storage will be extended to also provide
> uniform storage for *non*-time-related data, like the random state or
> architecture-specific data. These will have their own pages and data
> structures, so rename 'vdso_data' into 'vdso_time_data' to make that
> split clear from the name.
> 
> Also introduce a new consistent naming scheme for the symbols related to
> the vDSO, which makes it clear if the symbol is accessible from
> userspace or kernel space and the type of data behind the symbol.
> 
> The generic fault handler contains an optimization to prefault the vvar
> page when the timens page is accessed. This was lifted from s390 and x86.
> 
> Co-developed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   MAINTAINERS                    |  1 +
>   include/linux/time_namespace.h |  1 +
>   include/linux/vdso_datastore.h | 10 +++++
>   include/vdso/datapage.h        | 69 +++++++++++++++++++++++++----
>   lib/Kconfig                    |  1 +
>   lib/Makefile                   |  2 +
>   lib/vdso_kernel/Kconfig        |  7 +++
>   lib/vdso_kernel/Makefile       |  3 ++
>   lib/vdso_kernel/datastore.c    | 99 ++++++++++++++++++++++++++++++++++++++++++

There is only one single file, namely datastore.c. You don't need a new 
directory for that, I should go in lib/vdso/


>   9 files changed, 185 insertions(+), 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e930c7a58b13d8bbe6bf133ba7b36aa24c2b5e0..9d947e1e90ff3c6060e56f3b7eaa28cd60d6191c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9677,6 +9677,7 @@ F:	include/asm-generic/vdso/vsyscall.h
>   F:	include/vdso/
>   F:	kernel/time/vsyscall.c
>   F:	lib/vdso/
> +F:	lib/vdso_kernel/

New dir not needed

>   
>   GENWQE (IBM Generic Workqueue Card)
>   M:	Frank Haverkamp <haver@linux.ibm.com>
> diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
> index 876e31b4461d0ee01fe2bd3d136acdea2611789f..4b81db223f5450218dfaf553b24195be9ba97c08 100644
> --- a/include/linux/time_namespace.h
> +++ b/include/linux/time_namespace.h
> @@ -8,6 +8,7 @@
>   #include <linux/ns_common.h>
>   #include <linux/err.h>
>   #include <linux/time64.h>
> +#include <vdso/datapage.h>
>   
>   struct user_namespace;
>   extern struct user_namespace init_user_ns;
> diff --git a/include/linux/vdso_datastore.h b/include/linux/vdso_datastore.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..a91fa24b06e09321fdff8c2c7bdfbc1b206db574
> --- /dev/null
> +++ b/include/linux/vdso_datastore.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_VDSO_DATASTORE_H
> +#define _LINUX_VDSO_DATASTORE_H
> +
> +#include <linux/mm_types.h>
> +
> +extern const struct vm_special_mapping vdso_vvar_mapping;
> +struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned long addr);
> +
> +#endif /* _LINUX_VDSO_DATASTORE_H */
> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
> index d967baa0cd0c65784e38dc4fcd7b9e8273923947..69af424413db1f265607d0f1bdbf88550548c5ba 100644
> --- a/include/vdso/datapage.h
> +++ b/include/vdso/datapage.h
> @@ -45,11 +45,11 @@ struct arch_vdso_time_data {};
>    *
>    * There is one vdso_timestamp object in vvar for each vDSO-accelerated
>    * clock_id. For high-resolution clocks, this encodes the time
> - * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
> + * corresponding to vdso_time_data.cycle_last. For coarse clocks this encodes
>    * the actual time.
>    *
>    * To be noticed that for highres clocks nsec is left-shifted by
> - * vdso_data.cs[x].shift.
> + * vdso_time_data[x].shift.
>    */
>   struct vdso_timestamp {
>   	u64	sec;
> @@ -57,7 +57,7 @@ struct vdso_timestamp {
>   };
>   
>   /**
> - * struct vdso_data - vdso datapage representation
> + * struct vdso_time_data - vdso datapage representation
>    * @seq:		timebase sequence counter
>    * @clock_mode:		clock mode
>    * @cycle_last:		timebase at clocksource init
> @@ -74,7 +74,7 @@ struct vdso_timestamp {
>    * @arch_data:		architecture specific data (optional, defaults
>    *			to an empty struct)
>    *
> - * vdso_data will be accessed by 64 bit and compat code at the same time
> + * vdso_time_data will be accessed by 64 bit and compat code at the same time
>    * so we should be careful before modifying this structure.
>    *
>    * The ordering of the struct members is optimized to have fast access to the
> @@ -92,7 +92,7 @@ struct vdso_timestamp {
>    * For clocks which are not affected by time namespace adjustment the
>    * offset must be zero.
>    */
> -struct vdso_data {
> +struct vdso_time_data {
>   	u32			seq;
>   
>   	s32			clock_mode;
> @@ -117,6 +117,8 @@ struct vdso_data {
>   	struct arch_vdso_time_data arch_data;
>   };
>   
> +#define vdso_data vdso_time_data
> +
>   /**
>    * struct vdso_rng_data - vdso RNG state information
>    * @generation:	counter representing the number of RNG reseeds
> @@ -136,18 +138,55 @@ struct vdso_rng_data {
>    * With the hidden visibility, the compiler simply generates a PC-relative
>    * relocation, and this is what we need.
>    */
> -extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
> -extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
> +#ifndef CONFIG_GENERIC_VDSO_DATA_STORE
> +extern struct vdso_time_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
> +extern struct vdso_time_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
>   extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden")));
> +#else
> +extern const struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visibility("hidden")));
> +extern const struct vdso_time_data vdso_u_timens_data[CS_BASES] __attribute__((visibility("hidden")));
> +
> +extern struct vdso_time_data *vdso_k_time_data;
> +#endif
>   
>   /**
>    * union vdso_data_store - Generic vDSO data page
>    */
>   union vdso_data_store {
> -	struct vdso_data	data[CS_BASES];
> +	struct vdso_time_data	data[CS_BASES];
>   	u8			page[1U << CONFIG_PAGE_SHIFT];
>   };
>   
> +#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
> +
> +enum vdso_pages {
> +	VDSO_TIME_PAGE_OFFSET,
> +	VDSO_TIMENS_PAGE_OFFSET,
> +	VDSO_NR_PAGES
> +};

Naming that VDSO_ is confusing. Most macros called VDSO_ are related to 
the VDSO Code. VDSO data related macros should be prefixed with VVAR_

> +
> +static __always_inline struct vdso_time_data *__arch_get_vdso_k_time_data(void)
> +{
> +	return vdso_k_time_data;
> +}
> +#define __arch_get_k_vdso_data __arch_get_vdso_k_time_data
> +
> +static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
> +{
> +	return vdso_u_time_data;
> +}
> +#define __arch_get_vdso_data __arch_get_vdso_u_time_data
> +
> +#ifdef CONFIG_TIME_NS
> +static __always_inline const struct vdso_time_data *__arch_get_vdso_u_timens_data(void)
> +{
> +	return vdso_u_timens_data;
> +}
> +#define __arch_get_timens_vdso_data(vd) __arch_get_vdso_u_timens_data()
> +#endif /* CONFIG_TIME_NS */
> +
> +#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
> +
>   /*
>    * The generic vDSO implementation requires that gettimeofday.h
>    * provides:
> @@ -164,6 +203,20 @@ union vdso_data_store {
>   #include <asm/vdso/gettimeofday.h>
>   #endif /* ENABLE_COMPAT_VDSO */
>   
> +#else /* !__ASSEMBLY__ */
> +
> +#ifdef CONFIG_TIME_NS
> +#define __vdso_u_timens_data	PROVIDE(vdso_u_timens_data = vdso_u_data + PAGE_SIZE);
> +#else
> +#define __vdso_u_timens_data
> +#endif
> +
> +#define VDSO_VVAR_SYMS						\
> +	PROVIDE(vdso_u_data = . - __VDSO_PAGES * PAGE_SIZE);	\
> +	PROVIDE(vdso_u_time_data = vdso_u_data);		\
> +	__vdso_u_timens_data					\
> +
> +
>   #endif /* !__ASSEMBLY__ */
>   
>   #endif /* __VDSO_DATAPAGE_H */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 5a318f753b2f44cb0a7905cc0092e81c133bc112..7d59b2c10ce5ffab03378ead254d9f9017a4482f 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -659,6 +659,7 @@ config UCS2_STRING
>   # generic vdso
>   #
>   source "lib/vdso/Kconfig"
> +source "lib/vdso_kernel/Kconfig"
>   
>   source "lib/fonts/Kconfig"
>   
> diff --git a/lib/Makefile b/lib/Makefile
> index a8155c972f02856fcc61ee949ddda436cfe211ff..aeedeea86b26cee50d7ced18f9b77b3c51201930 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -401,3 +401,5 @@ obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
>   obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
>   
>   subdir-$(CONFIG_FORTIFY_SOURCE) += test_fortify
> +
> +obj-y += vdso_kernel/

No need for a new directory

> diff --git a/lib/vdso_kernel/Kconfig b/lib/vdso_kernel/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..0c7ade9b3ece67c0c0ca892544b9e29e53c860c4
> --- /dev/null
> +++ b/lib/vdso_kernel/Kconfig
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config GENERIC_VDSO_DATA_STORE
> +	bool
> +	depends on HAVE_GENERIC_VDSO
> +	help
> +	  Selected by architectures that use the generic vDSO data store.
> diff --git a/lib/vdso_kernel/Makefile b/lib/vdso_kernel/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..4826e49f9edbdb48506b50957584ed89bde5f37f
> --- /dev/null
> +++ b/lib/vdso_kernel/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_GENERIC_VDSO_DATA_STORE) += datastore.o
> diff --git a/lib/vdso_kernel/datastore.c b/lib/vdso_kernel/datastore.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c9cd269b1ed1b6cdd5fdf9fe929d0b778314b962
> --- /dev/null
> +++ b/lib/vdso_kernel/datastore.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/linkage.h>
> +#include <linux/mmap_lock.h>
> +#include <linux/mm.h>
> +#include <linux/time_namespace.h>
> +#include <linux/types.h>
> +#include <linux/vdso_datastore.h>
> +#include <vdso/datapage.h>
> +
> +/*
> + * The vDSO data page.
> + */
> +static union vdso_data_store vdso_time_data_store __page_aligned_data;
> +struct vdso_time_data *vdso_k_time_data = vdso_time_data_store.data;
> +static_assert(sizeof(vdso_time_data_store) == PAGE_SIZE);
> +
> +static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
> +			     struct vm_area_struct *vma, struct vm_fault *vmf)
> +{
> +	struct page *timens_page = find_timens_vvar_page(vma);
> +	unsigned long addr, pfn;
> +	vm_fault_t err;
> +
> +	switch (vmf->pgoff) {
> +	case VDSO_TIME_PAGE_OFFSET:
> +		pfn = __phys_to_pfn(__pa_symbol(vdso_k_time_data));
> +		if (timens_page) {
> +			/*
> +			 * Fault in VVAR page too, since it will be accessed
> +			 * to get clock data anyway.
> +			 */
> +			addr = vmf->address + VDSO_TIMENS_PAGE_OFFSET * PAGE_SIZE;
> +			err = vmf_insert_pfn(vma, addr, pfn);
> +			if (unlikely(err & VM_FAULT_ERROR))
> +				return err;
> +			pfn = page_to_pfn(timens_page);
> +		}
> +		break;
> +	case VDSO_TIMENS_PAGE_OFFSET:
> +		/*
> +		 * If a task belongs to a time namespace then a namespace
> +		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
> +		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
> +		 * offset.
> +		 * See also the comment near timens_setup_vdso_data().
> +		 */
> +		if (!IS_ENABLED(CONFIG_TIME_NS) || !timens_page)
> +			return VM_FAULT_SIGBUS;
> +		pfn = __phys_to_pfn(__pa_symbol(vdso_k_time_data));
> +		break;
> +	default:
> +		return VM_FAULT_SIGBUS;
> +	}
> +
> +	return vmf_insert_pfn(vma, vmf->address, pfn);
> +}
> +
> +const struct vm_special_mapping vdso_vvar_mapping = {
> +	.name	= "[vvar]",
> +	.fault	= vvar_fault,
> +};
> +
> +struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned long addr)
> +{
> +	return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SIZE,
> +					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP | VM_PFNMAP,
> +					&vdso_vvar_mapping);
> +}
> +
> +#ifdef CONFIG_TIME_NS
> +/*
> + * The vvar page layout depends on whether a task belongs to the root or
> + * non-root time namespace. Whenever a task changes its namespace, the VVAR
> + * page tables are cleared and then they will be re-faulted with a
> + * corresponding layout.
> + * See also the comment near timens_setup_vdso_data() for details.
> + */
> +int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
> +{
> +	struct mm_struct *mm = task->mm;
> +	struct vm_area_struct *vma;
> +	VMA_ITERATOR(vmi, mm, 0);
> +
> +	mmap_read_lock(mm);
> +	for_each_vma(vmi, vma) {
> +		if (vma_is_special_mapping(vma, &vdso_vvar_mapping))
> +			zap_vma_pages(vma);
> +	}
> +	mmap_read_unlock(mm);
> +
> +	return 0;
> +}
> +#endif
> +
> +struct vdso_time_data *arch_get_vdso_data(void *vvar_page)
> +{
> +	return (struct vdso_time_data *)vvar_page;
> +}
> 


