Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8087813163B
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jan 2020 17:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgAFQlB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 Jan 2020 11:41:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42680 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQlB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Jan 2020 11:41:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so42900473qtq.9
        for <linux-s390@vger.kernel.org>; Mon, 06 Jan 2020 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DFcuK4X/UUJLk4ruiVCgQbLVxObW665BJKm+aavigS0=;
        b=R0fF4H1GmJ4CUoqbfBTj0/x4N7W6Xzx5ngHYkHkHafLcehpBN0XLDw+1j254xb9/ML
         ECSb0xaGd6lsYgmX42/AiLu+zJ1JaZVwNtK/lJoH+l2VxN7jpZfvlnbARu3435Rk0haE
         bdmae6srpJ//x0XvDRMaKxOtYKA/D0Hfqo5MkpdH8IUcH+DYX2pBp3SZSDOL2KUV75UL
         yvlvi6ff0foGt4qNt03LG4v/8YdZ1zR8rxD1Pfjs9gal7GiVheg73sM4SVNA6jNxKfTr
         xascTeQ8DIZeEmiTUaPc/OChRgN+2YANoei/AcfuSZtRmtg1w1lJDi8XtYtoAL4rynm4
         x13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DFcuK4X/UUJLk4ruiVCgQbLVxObW665BJKm+aavigS0=;
        b=BRwMZnzzIATETskL7WaDgl9a4aF4HP+PzBV1V/Y9VG2FZ0Kmp4f95GRwJolZnSP3FR
         VRCYYjO1GoYteTxxj2/ZcM+wZ7YTRc6SdfZzkbaQ3bx9CbDDqe2IH5LUrU/Fl+Rf/TVc
         DS1oYeJLuevzpd7icJFKq5x/ujphGEgMbPw0ILwD8FsudQEKvpY62GG0+tnTOFnX3Bn5
         Rdnr+ZcOGpB4vDCtZICtSE+G/vOkcHE8H1Qwd8+VYn9v2q+LcAxRlsPhE04TZ1+kXRoK
         IykteNzuHFd/bcCphTBiWjrkldukz0t2Nf9OCbIlq6RVfwsluYkHnG6C/uu7dtOj833C
         epyA==
X-Gm-Message-State: APjAAAVmu+6nEjEvW5+SvmrGkJQBP3haTearu0//wCSyv7p7EcrXHOUH
        aZvzXGen9eArMtBjj0D7YfS/Aw==
X-Google-Smtp-Source: APXvYqxx4xfRerAhp62npcyI2Raw+ucDUWsCxyklKFVllsYbRs8Jfxoqwz1EaC28k2fM41F9yEBwSQ==
X-Received: by 2002:ac8:3853:: with SMTP id r19mr76518266qtb.69.1578328860126;
        Mon, 06 Jan 2020 08:41:00 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6941])
        by smtp.gmail.com with ESMTPSA id l25sm20815974qkk.115.2020.01.06.08.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 08:40:59 -0800 (PST)
Subject: Re: [PATCH v3 6/6] btrfs: Use larger zlib buffer for s390 hardware
 compression
To:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>
Cc:     Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200103223334.20669-1-zaslonko@linux.ibm.com>
 <20200103223334.20669-7-zaslonko@linux.ibm.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d9aa84d2-3274-9310-234f-b91e07c9fc0e@toxicpanda.com>
Date:   Mon, 6 Jan 2020 11:40:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200103223334.20669-7-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 1/3/20 5:33 PM, Mikhail Zaslonko wrote:
> In order to benefit from s390 zlib hardware compression support,
> increase the btrfs zlib workspace buffer size from 1 to 4 pages (if
> s390 zlib hardware support is enabled on the machine). This brings up
> to 60% better performance in hardware on s390 compared to the PAGE_SIZE
> buffer and much more compared to the software zlib processing in btrfs.
> In case of memory pressure fall back to a single page buffer during
> workspace allocation.
> 
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> ---
>   fs/btrfs/compression.c |   2 +-
>   fs/btrfs/zlib.c        | 128 ++++++++++++++++++++++++++++++-----------
>   2 files changed, 94 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index ee834ef7beb4..6bd0e75a822c 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1285,7 +1285,7 @@ int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
>   	/* copy bytes from the working buffer into the pages */
>   	while (working_bytes > 0) {
>   		bytes = min_t(unsigned long, bvec.bv_len,
> -				PAGE_SIZE - buf_offset);
> +				PAGE_SIZE - (buf_offset % PAGE_SIZE));
>   		bytes = min(bytes, working_bytes);
>   
>   		kaddr = kmap_atomic(bvec.bv_page);
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index a6c90a003c12..159486801631 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -20,9 +20,12 @@
>   #include <linux/refcount.h>
>   #include "compression.h"
>   
> +#define ZLIB_DFLTCC_BUF_SIZE    (4 * PAGE_SIZE)
> +
>   struct workspace {
>   	z_stream strm;
>   	char *buf;
> +	unsigned long buf_size;
>   	struct list_head list;
>   	int level;
>   };
> @@ -61,7 +64,17 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
>   			zlib_inflate_workspacesize());
>   	workspace->strm.workspace = kvmalloc(workspacesize, GFP_KERNEL);
>   	workspace->level = level;
> -	workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	workspace->buf = NULL;
> +	if (zlib_deflate_dfltcc_enabled()) {
> +		workspace->buf = kmalloc(ZLIB_DFLTCC_BUF_SIZE,
> +					 __GFP_NOMEMALLOC | __GFP_NORETRY |
> +					 __GFP_NOWARN | GFP_NOIO);
> +		workspace->buf_size = ZLIB_DFLTCC_BUF_SIZE;
> +	}
> +	if (!workspace->buf) {
> +		workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +		workspace->buf_size = PAGE_SIZE;
> +	}
>   	if (!workspace->strm.workspace || !workspace->buf)
>   		goto fail;
>   
> @@ -78,6 +91,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   		unsigned long *total_in, unsigned long *total_out)
>   {
>   	struct workspace *workspace = list_entry(ws, struct workspace, list);
> +	int i;
>   	int ret;
>   	char *data_in;
>   	char *cpage_out;
> @@ -85,6 +99,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   	struct page *in_page = NULL;
>   	struct page *out_page = NULL;
>   	unsigned long bytes_left;
> +	unsigned long in_buf_pages;
>   	unsigned long len = *total_out;
>   	unsigned long nr_dest_pages = *out_pages;
>   	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
> @@ -102,9 +117,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   	workspace->strm.total_in = 0;
>   	workspace->strm.total_out = 0;
>   
> -	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
> -	data_in = kmap(in_page);
> -
>   	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>   	if (out_page == NULL) {
>   		ret = -ENOMEM;
> @@ -114,12 +126,48 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   	pages[0] = out_page;
>   	nr_pages = 1;
>   
> -	workspace->strm.next_in = data_in;
> +	workspace->strm.next_in = workspace->buf;
> +	workspace->strm.avail_in = 0;
>   	workspace->strm.next_out = cpage_out;
>   	workspace->strm.avail_out = PAGE_SIZE;
> -	workspace->strm.avail_in = min(len, PAGE_SIZE);
>   
>   	while (workspace->strm.total_in < len) {
> +		/* get next input pages and copy the contents to
> +		 * the workspace buffer if required
> +		 */
> +		if (workspace->strm.avail_in == 0) {
> +			bytes_left = len - workspace->strm.total_in;
> +			in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
> +					   workspace->buf_size / PAGE_SIZE);
> +			if (in_buf_pages > 1) {
> +				for (i = 0; i < in_buf_pages; i++) {
> +					if (in_page) {
> +						kunmap(in_page);
> +						put_page(in_page);
> +					}
> +					in_page = find_get_page(mapping,
> +								start >> PAGE_SHIFT);
> +					data_in = kmap(in_page);
> +					memcpy(workspace->buf + i*PAGE_SIZE,
> +					       data_in, PAGE_SIZE);
> +					start += PAGE_SIZE;
> +				}

Is there a reason to leave the last in_page mapped here?  I realize we'll clean 
it up further down, but since we're copying everything into the buf anyway why 
not just map->copy->unmap for everything?

> +				workspace->strm.next_in = workspace->buf;
> +			} else {
> +				if (in_page) {
> +					kunmap(in_page);
> +					put_page(in_page);
> +				}
> +				in_page = find_get_page(mapping,
> +							start >> PAGE_SHIFT);
> +				data_in = kmap(in_page);
> +				start += PAGE_SIZE;
> +				workspace->strm.next_in = data_in;
> +			}
> +			workspace->strm.avail_in = min(bytes_left,
> +						       workspace->buf_size);
> +		}
> +
>   		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
>   		if (ret != Z_OK) {
>   			pr_debug("BTRFS: deflate in loop returned %d\n",
> @@ -136,6 +184,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>   			ret = -E2BIG;
>   			goto out;
>   		}
> +

Extra newline.  Thanks,

Josef
