Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3CD132397
	for <lists+linux-s390@lfdr.de>; Tue,  7 Jan 2020 11:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgAGKbG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 Jan 2020 05:31:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727722AbgAGKbG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jan 2020 05:31:06 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007AKcGF101074;
        Tue, 7 Jan 2020 05:30:57 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xb8s9jgs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 05:30:56 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 007AUmIv000752;
        Tue, 7 Jan 2020 10:30:56 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 2xajb6gsb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 10:30:55 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 007AUs1K24052158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jan 2020 10:30:54 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28403124058;
        Tue,  7 Jan 2020 10:30:54 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA721124052;
        Tue,  7 Jan 2020 10:30:52 +0000 (GMT)
Received: from [9.152.98.193] (unknown [9.152.98.193])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue,  7 Jan 2020 10:30:52 +0000 (GMT)
Subject: Re: [PATCH v3 6/6] btrfs: Use larger zlib buffer for s390 hardware
 compression
To:     Josef Bacik <josef@toxicpanda.com>,
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
 <d9aa84d2-3274-9310-234f-b91e07c9fc0e@toxicpanda.com>
From:   Zaslonko Mikhail <zaslonko@linux.ibm.com>
Message-ID: <ad15739f-db2a-3b2a-1097-d80feadcfd40@linux.ibm.com>
Date:   Tue, 7 Jan 2020 11:30:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <d9aa84d2-3274-9310-234f-b91e07c9fc0e@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_02:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070086
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello,

On 06.01.2020 17:40, Josef Bacik wrote:
> On 1/3/20 5:33 PM, Mikhail Zaslonko wrote:
>> In order to benefit from s390 zlib hardware compression support,
>> increase the btrfs zlib workspace buffer size from 1 to 4 pages (if
>> s390 zlib hardware support is enabled on the machine). This brings up
>> to 60% better performance in hardware on s390 compared to the PAGE_SIZE
>> buffer and much more compared to the software zlib processing in btrfs.
>> In case of memory pressure fall back to a single page buffer during
>> workspace allocation.
>>
>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>> ---
>>   fs/btrfs/compression.c |   2 +-
>>   fs/btrfs/zlib.c        | 128 ++++++++++++++++++++++++++++++-----------
>>   2 files changed, 94 insertions(+), 36 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index ee834ef7beb4..6bd0e75a822c 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -1285,7 +1285,7 @@ int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
>>       /* copy bytes from the working buffer into the pages */
>>       while (working_bytes > 0) {
>>           bytes = min_t(unsigned long, bvec.bv_len,
>> -                PAGE_SIZE - buf_offset);
>> +                PAGE_SIZE - (buf_offset % PAGE_SIZE));
>>           bytes = min(bytes, working_bytes);
>>             kaddr = kmap_atomic(bvec.bv_page);
>> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
>> index a6c90a003c12..159486801631 100644
>> --- a/fs/btrfs/zlib.c
>> +++ b/fs/btrfs/zlib.c
>> @@ -20,9 +20,12 @@
>>   #include <linux/refcount.h>
>>   #include "compression.h"
>>   +#define ZLIB_DFLTCC_BUF_SIZE    (4 * PAGE_SIZE)
>> +
>>   struct workspace {
>>       z_stream strm;
>>       char *buf;
>> +    unsigned long buf_size;
>>       struct list_head list;
>>       int level;
>>   };
>> @@ -61,7 +64,17 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
>>               zlib_inflate_workspacesize());
>>       workspace->strm.workspace = kvmalloc(workspacesize, GFP_KERNEL);
>>       workspace->level = level;
>> -    workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>> +    workspace->buf = NULL;
>> +    if (zlib_deflate_dfltcc_enabled()) {
>> +        workspace->buf = kmalloc(ZLIB_DFLTCC_BUF_SIZE,
>> +                     __GFP_NOMEMALLOC | __GFP_NORETRY |
>> +                     __GFP_NOWARN | GFP_NOIO);
>> +        workspace->buf_size = ZLIB_DFLTCC_BUF_SIZE;
>> +    }
>> +    if (!workspace->buf) {
>> +        workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>> +        workspace->buf_size = PAGE_SIZE;
>> +    }
>>       if (!workspace->strm.workspace || !workspace->buf)
>>           goto fail;
>>   @@ -78,6 +91,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>           unsigned long *total_in, unsigned long *total_out)
>>   {
>>       struct workspace *workspace = list_entry(ws, struct workspace, list);
>> +    int i;
>>       int ret;
>>       char *data_in;
>>       char *cpage_out;
>> @@ -85,6 +99,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>       struct page *in_page = NULL;
>>       struct page *out_page = NULL;
>>       unsigned long bytes_left;
>> +    unsigned long in_buf_pages;
>>       unsigned long len = *total_out;
>>       unsigned long nr_dest_pages = *out_pages;
>>       const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
>> @@ -102,9 +117,6 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>       workspace->strm.total_in = 0;
>>       workspace->strm.total_out = 0;
>>   -    in_page = find_get_page(mapping, start >> PAGE_SHIFT);
>> -    data_in = kmap(in_page);
>> -
>>       out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>>       if (out_page == NULL) {
>>           ret = -ENOMEM;
>> @@ -114,12 +126,48 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>       pages[0] = out_page;
>>       nr_pages = 1;
>>   -    workspace->strm.next_in = data_in;
>> +    workspace->strm.next_in = workspace->buf;
>> +    workspace->strm.avail_in = 0;
>>       workspace->strm.next_out = cpage_out;
>>       workspace->strm.avail_out = PAGE_SIZE;
>> -    workspace->strm.avail_in = min(len, PAGE_SIZE);
>>         while (workspace->strm.total_in < len) {
>> +        /* get next input pages and copy the contents to
>> +         * the workspace buffer if required
>> +         */
>> +        if (workspace->strm.avail_in == 0) {
>> +            bytes_left = len - workspace->strm.total_in;
>> +            in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
>> +                       workspace->buf_size / PAGE_SIZE);
>> +            if (in_buf_pages > 1) {
>> +                for (i = 0; i < in_buf_pages; i++) {
>> +                    if (in_page) {
>> +                        kunmap(in_page);
>> +                        put_page(in_page);
>> +                    }
>> +                    in_page = find_get_page(mapping,
>> +                                start >> PAGE_SHIFT);
>> +                    data_in = kmap(in_page);
>> +                    memcpy(workspace->buf + i*PAGE_SIZE,
>> +                           data_in, PAGE_SIZE);
>> +                    start += PAGE_SIZE;
>> +                }
> 
> Is there a reason to leave the last in_page mapped here?  I realize we'll clean it up further down, but since we're copying everything into the buf anyway why not just map->copy->unmap for everything?

The idea was not to copy the last data chunk if it fits in a single page, thus using the same code flow as for a PAGE_SIZE buffer (the ELSE branch below). 

> 
>> +                workspace->strm.next_in = workspace->buf;
>> +            } else {
>> +                if (in_page) {
>> +                    kunmap(in_page);
>> +                    put_page(in_page);
>> +                }
>> +                in_page = find_get_page(mapping,
>> +                            start >> PAGE_SHIFT);
>> +                data_in = kmap(in_page);
>> +                start += PAGE_SIZE;
>> +                workspace->strm.next_in = data_in;
>> +            }
>> +            workspace->strm.avail_in = min(bytes_left,
>> +                               workspace->buf_size);
>> +        }
>> +
>>           ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
>>           if (ret != Z_OK) {
>>               pr_debug("BTRFS: deflate in loop returned %d\n",
>> @@ -136,6 +184,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
>>               ret = -E2BIG;
>>               goto out;
>>           }
>> +
> 
> Extra newline.  Thanks,
> 
> Josef
