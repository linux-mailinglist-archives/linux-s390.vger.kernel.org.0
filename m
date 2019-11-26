Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9CD10A08C
	for <lists+linux-s390@lfdr.de>; Tue, 26 Nov 2019 15:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfKZOlm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 26 Nov 2019 09:41:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728174AbfKZOll (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 Nov 2019 09:41:41 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQEaHu5122360
        for <linux-s390@vger.kernel.org>; Tue, 26 Nov 2019 09:41:40 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wh41mwhrv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 26 Nov 2019 09:41:39 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zaslonko@linux.ibm.com>;
        Tue, 26 Nov 2019 14:41:38 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Nov 2019 14:41:34 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAQEfWlv45613184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 14:41:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91B325204E;
        Tue, 26 Nov 2019 14:41:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3E79D52057;
        Tue, 26 Nov 2019 14:41:32 +0000 (GMT)
From:   Mikhail Zaslonko <zaslonko@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Richard Purdie <rpurdie@rpsys.net>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] btrfs: Increase buffer size for zlib functions
Date:   Tue, 26 Nov 2019 15:41:30 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191126144130.75710-1-zaslonko@linux.ibm.com>
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19112614-0008-0000-0000-00000338830F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112614-0009-0000-0000-00004A5787A4
Message-Id: <20191126144130.75710-6-zaslonko@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-26_03:2019-11-26,2019-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911260129
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Due to the small size of zlib buffer (1 page) set in btrfs code, s390
hardware compression is rather limited in terms of performance. Increasing
the buffer size to 4 pages would bring significant benefit for s390
hardware compression (up to 60% better performance compared to the
PAGE_SIZE buffer) and should not bring much overhead in terms of memory
consumption due to order 2 allocations.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 fs/btrfs/compression.c |   2 +-
 fs/btrfs/zlib.c        | 109 ++++++++++++++++++++++++++---------------
 2 files changed, 70 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b05b361e2062..f789b356fd8b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1158,7 +1158,7 @@ int btrfs_decompress_buf2page(const char *buf, unsigned long buf_start,
 	/* copy bytes from the working buffer into the pages */
 	while (working_bytes > 0) {
 		bytes = min_t(unsigned long, bvec.bv_len,
-				PAGE_SIZE - buf_offset);
+				PAGE_SIZE - (buf_offset % PAGE_SIZE));
 		bytes = min(bytes, working_bytes);
 
 		kaddr = kmap_atomic(bvec.bv_page);
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index df1aace5df50..c5b4654e1242 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -20,6 +20,8 @@
 #include <linux/refcount.h>
 #include "compression.h"
 
+#define ZLIB_BUF_SIZE    (4 * PAGE_SIZE)
+
 struct workspace {
 	z_stream strm;
 	char *buf;
@@ -76,7 +78,7 @@ static struct list_head *zlib_alloc_workspace(unsigned int level)
 			zlib_inflate_workspacesize());
 	workspace->strm.workspace = kvmalloc(workspacesize, GFP_KERNEL);
 	workspace->level = level;
-	workspace->buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	workspace->buf = kmalloc(ZLIB_BUF_SIZE, GFP_KERNEL);
 	if (!workspace->strm.workspace || !workspace->buf)
 		goto fail;
 
@@ -97,6 +99,7 @@ static int zlib_compress_pages(struct list_head *ws,
 			       unsigned long *total_out)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	int i;
 	int ret;
 	char *data_in;
 	char *cpage_out;
@@ -104,6 +107,7 @@ static int zlib_compress_pages(struct list_head *ws,
 	struct page *in_page = NULL;
 	struct page *out_page = NULL;
 	unsigned long bytes_left;
+	unsigned long in_buf_pages;
 	unsigned long len = *total_out;
 	unsigned long nr_dest_pages = *out_pages;
 	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
@@ -121,9 +125,6 @@ static int zlib_compress_pages(struct list_head *ws,
 	workspace->strm.total_in = 0;
 	workspace->strm.total_out = 0;
 
-	in_page = find_get_page(mapping, start >> PAGE_SHIFT);
-	data_in = kmap(in_page);
-
 	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
 	if (out_page == NULL) {
 		ret = -ENOMEM;
@@ -133,12 +134,34 @@ static int zlib_compress_pages(struct list_head *ws,
 	pages[0] = out_page;
 	nr_pages = 1;
 
-	workspace->strm.next_in = data_in;
+	workspace->strm.next_in = workspace->buf;
+	workspace->strm.avail_in = 0;
 	workspace->strm.next_out = cpage_out;
 	workspace->strm.avail_out = PAGE_SIZE;
-	workspace->strm.avail_in = min(len, PAGE_SIZE);
 
 	while (workspace->strm.total_in < len) {
+		/* get next set of pages and copy their contents to
+		 * the input buffer for the following deflate call
+		 */
+		if (workspace->strm.avail_in == 0) {
+			bytes_left = len - workspace->strm.total_in;
+			in_buf_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
+					   ZLIB_BUF_SIZE / PAGE_SIZE);
+			for (i = 0; i < in_buf_pages; i++) {
+				in_page = find_get_page(mapping,
+							start >> PAGE_SHIFT);
+				data_in = kmap(in_page);
+				memcpy(workspace->buf + i*PAGE_SIZE, data_in,
+				       PAGE_SIZE);
+				kunmap(in_page);
+				put_page(in_page);
+				start += PAGE_SIZE;
+			}
+			workspace->strm.avail_in = min(bytes_left,
+						       ZLIB_BUF_SIZE);
+			workspace->strm.next_in = workspace->buf;
+		}
+
 		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
 		if (ret != Z_OK) {
 			pr_debug("BTRFS: deflate in loop returned %d\n",
@@ -149,12 +172,13 @@ static int zlib_compress_pages(struct list_head *ws,
 		}
 
 		/* we're making it bigger, give up */
-		if (workspace->strm.total_in > 8192 &&
+		if (workspace->strm.total_in > ZLIB_BUF_SIZE &&
 		    workspace->strm.total_in <
 		    workspace->strm.total_out) {
 			ret = -E2BIG;
 			goto out;
 		}
+
 		/* we need another page for writing out.  Test this
 		 * before the total_in so we will pull in a new page for
 		 * the stream end if required
@@ -180,33 +204,42 @@ static int zlib_compress_pages(struct list_head *ws,
 		/* we're all done */
 		if (workspace->strm.total_in >= len)
 			break;
-
-		/* we've read in a full page, get a new one */
-		if (workspace->strm.avail_in == 0) {
-			if (workspace->strm.total_out > max_out)
-				break;
-
-			bytes_left = len - workspace->strm.total_in;
-			kunmap(in_page);
-			put_page(in_page);
-
-			start += PAGE_SIZE;
-			in_page = find_get_page(mapping,
-						start >> PAGE_SHIFT);
-			data_in = kmap(in_page);
-			workspace->strm.avail_in = min(bytes_left,
-							   PAGE_SIZE);
-			workspace->strm.next_in = data_in;
-		}
+		if (workspace->strm.total_out > max_out)
+			break;
 	}
 	workspace->strm.avail_in = 0;
-	ret = zlib_deflate(&workspace->strm, Z_FINISH);
-	zlib_deflateEnd(&workspace->strm);
-
-	if (ret != Z_STREAM_END) {
-		ret = -EIO;
-		goto out;
+	/* call deflate with Z_FINISH flush parameter providing more output
+	 * space but no more input data, until it returns with Z_STREAM_END
+	 */
+	while (ret != Z_STREAM_END) {
+		ret = zlib_deflate(&workspace->strm, Z_FINISH);
+		if (ret == Z_STREAM_END)
+			break;
+		if (ret != Z_OK && ret != Z_BUF_ERROR) {
+			zlib_deflateEnd(&workspace->strm);
+			ret = -EIO;
+			goto out;
+		} else if (workspace->strm.avail_out == 0) {
+			/* get another page for the stream end */
+			kunmap(out_page);
+			if (nr_pages == nr_dest_pages) {
+				out_page = NULL;
+				ret = -E2BIG;
+				goto out;
+			}
+			out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+			if (out_page == NULL) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			cpage_out = kmap(out_page);
+			pages[nr_pages] = out_page;
+			nr_pages++;
+			workspace->strm.avail_out = PAGE_SIZE;
+			workspace->strm.next_out = cpage_out;
+		}
 	}
+	zlib_deflateEnd(&workspace->strm);
 
 	if (workspace->strm.total_out >= workspace->strm.total_in) {
 		ret = -E2BIG;
@@ -221,10 +254,6 @@ static int zlib_compress_pages(struct list_head *ws,
 	if (out_page)
 		kunmap(out_page);
 
-	if (in_page) {
-		kunmap(in_page);
-		put_page(in_page);
-	}
 	return ret;
 }
 
@@ -250,7 +279,7 @@ static int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 	workspace->strm.total_out = 0;
 	workspace->strm.next_out = workspace->buf;
-	workspace->strm.avail_out = PAGE_SIZE;
+	workspace->strm.avail_out = ZLIB_BUF_SIZE;
 
 	/* If it's deflate, and it's got no preset dictionary, then
 	   we can tell zlib to skip the adler32 check. */
@@ -289,7 +318,7 @@ static int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		}
 
 		workspace->strm.next_out = workspace->buf;
-		workspace->strm.avail_out = PAGE_SIZE;
+		workspace->strm.avail_out = ZLIB_BUF_SIZE;
 
 		if (workspace->strm.avail_in == 0) {
 			unsigned long tmp;
@@ -340,7 +369,7 @@ static int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 	workspace->strm.total_in = 0;
 
 	workspace->strm.next_out = workspace->buf;
-	workspace->strm.avail_out = PAGE_SIZE;
+	workspace->strm.avail_out = ZLIB_BUF_SIZE;
 	workspace->strm.total_out = 0;
 	/* If it's deflate, and it's got no preset dictionary, then
 	   we can tell zlib to skip the adler32 check. */
@@ -384,7 +413,7 @@ static int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 			buf_offset = 0;
 
 		bytes = min(PAGE_SIZE - pg_offset,
-			    PAGE_SIZE - buf_offset);
+			    PAGE_SIZE - (buf_offset % PAGE_SIZE));
 		bytes = min(bytes, bytes_left);
 
 		kaddr = kmap_atomic(dest_page);
@@ -395,7 +424,7 @@ static int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 		bytes_left -= bytes;
 next:
 		workspace->strm.next_out = workspace->buf;
-		workspace->strm.avail_out = PAGE_SIZE;
+		workspace->strm.avail_out = ZLIB_BUF_SIZE;
 	}
 
 	if (ret != Z_STREAM_END && bytes_left != 0)
-- 
2.17.1

