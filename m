Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1A2160BF5
	for <lists+linux-s390@lfdr.de>; Mon, 17 Feb 2020 08:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgBQHzy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 17 Feb 2020 02:55:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726267AbgBQHzx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 02:55:53 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01H7nKSw017190
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 02:55:52 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6dh3j528-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 02:55:52 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 17 Feb 2020 07:55:50 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Feb 2020 07:55:47 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01H7tloG1180152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Feb 2020 07:55:47 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 046FA4C040;
        Mon, 17 Feb 2020 07:55:47 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C31B64C046;
        Mon, 17 Feb 2020 07:55:46 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.211])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Feb 2020 07:55:46 +0000 (GMT)
Subject: Re: [kvms390:pv_worktree 5/40] arch/s390/kernel/setup.c:563:6: error:
 'prot_virt_host' undeclared; did you mean 'is_prot_virt_host'?
To:     kbuild test robot <lkp@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-s390@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>,
        Thomas Huth <thuth@redhat.com>
References: <202002151214.QFguG3zT%lkp@intel.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Date:   Mon, 17 Feb 2020 08:55:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202002151214.QFguG3zT%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021707-4275-0000-0000-000003A2AEFF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021707-4276-0000-0000-000038B6B233
Message-Id: <85febaae-c9ac-5060-5458-64287ec43774@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-17_04:2020-02-14,2020-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=924 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002170070
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

my bad due to a late change to fold in some last minute review. 
Will fix. 

On 15.02.20 05:33, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git pv_worktree
> head:   6a8cbdf8a1bdd3a4dff307780f9c00eeb2300adb
> commit: 76f352baed9166481516cfaf88968883635b931c [5/40] s390/protvirt: add ultravisor initialization
> config: s390-zfcpdump_defconfig (attached as .config)
> compiler: s390-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 76f352baed9166481516cfaf88968883635b931c
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=s390 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/s390/kernel/setup.c: In function 'setup_memory_end':
>>> arch/s390/kernel/setup.c:563:6: error: 'prot_virt_host' undeclared (first use in this function); did you mean 'is_prot_virt_host'?
>      if (prot_virt_host)
>          ^~~~~~~~~~~~~~
>          is_prot_virt_host
>    arch/s390/kernel/setup.c:563:6: note: each undeclared identifier is reported only once for each function it appears in
>    arch/s390/kernel/setup.c: In function 'setup_arch':
>    arch/s390/kernel/setup.c:1140:6: error: 'prot_virt_host' undeclared (first use in this function); did you mean 'is_prot_virt_host'?
>      if (prot_virt_host)
>          ^~~~~~~~~~~~~~
>          is_prot_virt_host
> 
> vim +563 arch/s390/kernel/setup.c
> 
>    544	
>    545	static void __init setup_memory_end(void)
>    546	{
>    547		unsigned long vmax, tmp;
>    548	
>    549		/* Choose kernel address space layout: 3 or 4 levels. */
>    550		if (IS_ENABLED(CONFIG_KASAN)) {
>    551			vmax = IS_ENABLED(CONFIG_KASAN_S390_4_LEVEL_PAGING)
>    552				   ? _REGION1_SIZE
>    553				   : _REGION2_SIZE;
>    554		} else {
>    555			tmp = (memory_end ?: max_physmem_end) / PAGE_SIZE;
>    556			tmp = tmp * (sizeof(struct page) + PAGE_SIZE);
>    557			if (tmp + vmalloc_size + MODULES_LEN <= _REGION2_SIZE)
>    558				vmax = _REGION2_SIZE; /* 3-level kernel page table */
>    559			else
>    560				vmax = _REGION1_SIZE; /* 4-level kernel page table */
>    561		}
>    562	
>  > 563		if (prot_virt_host)
>    564			adjust_to_uv_max(&vmax);
>    565	
>    566		/* module area is at the end of the kernel address space. */
>    567		MODULES_END = vmax;
>    568		MODULES_VADDR = MODULES_END - MODULES_LEN;
>    569		VMALLOC_END = MODULES_VADDR;
>    570		VMALLOC_START = VMALLOC_END - vmalloc_size;
>    571	
>    572		/* Split remaining virtual space between 1:1 mapping & vmemmap array */
>    573		tmp = VMALLOC_START / (PAGE_SIZE + sizeof(struct page));
>    574		/* vmemmap contains a multiple of PAGES_PER_SECTION struct pages */
>    575		tmp = SECTION_ALIGN_UP(tmp);
>    576		tmp = VMALLOC_START - tmp * sizeof(struct page);
>    577		tmp &= ~((vmax >> 11) - 1);	/* align to page table level */
>    578		tmp = min(tmp, 1UL << MAX_PHYSMEM_BITS);
>    579		vmemmap = (struct page *) tmp;
>    580	
>    581		/* Take care that memory_end is set and <= vmemmap */
>    582		memory_end = min(memory_end ?: max_physmem_end, (unsigned long)vmemmap);
>    583	#ifdef CONFIG_KASAN
>    584		/* fit in kasan shadow memory region between 1:1 and vmemmap */
>    585		memory_end = min(memory_end, KASAN_SHADOW_START);
>    586		vmemmap = max(vmemmap, (struct page *)KASAN_SHADOW_END);
>    587	#endif
>    588		max_pfn = max_low_pfn = PFN_DOWN(memory_end);
>    589		memblock_remove(memory_end, ULONG_MAX);
>    590	
>    591		pr_notice("The maximum memory size is %luMB\n", memory_end >> 20);
>    592	}
>    593	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

