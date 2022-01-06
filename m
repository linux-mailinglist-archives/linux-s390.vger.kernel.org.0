Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A8486242
	for <lists+linux-s390@lfdr.de>; Thu,  6 Jan 2022 10:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiAFJly (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 6 Jan 2022 04:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiAFJlu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jan 2022 04:41:50 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21430C061245
        for <linux-s390@vger.kernel.org>; Thu,  6 Jan 2022 01:41:50 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id j6so7150153edw.12
        for <linux-s390@vger.kernel.org>; Thu, 06 Jan 2022 01:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YqsVwEO+jjWJj3VTuBJekJMS2/bsatxl1m52PqZiI+s=;
        b=lIJ/52SDY7f1ElHzdxJz9cO2b1aByE4Kg5298+L5xuIxP/ItWuy7Z8P19lWo9W2aaX
         fUiddEInrWWpEhWD8GYr16iu4JhRr6B9rrthfSQAc5lt7PWqQGWIjx9OKoXFE8Vf/HE9
         gsj4bAPwK7hi7AI0qNZic3+tgfRlkyPaKLFFJV4wElVFb1/7FL0S6hkW0slr6XZilLqA
         4SfCiVpRv35C6NM+hhg3s9NvrszinJ3JzYO78wUDTHSe5WQUgYy224HkBjwNQopQKsD8
         1KPyTPnetHe5MabK5gCsNmFYIlM4hf6nuw/2vy+JjusE90IslmL2IQcGkg6rDlLR12nj
         JYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=YqsVwEO+jjWJj3VTuBJekJMS2/bsatxl1m52PqZiI+s=;
        b=7wBYpex1SZ6erKSd6FCDTPHqjAqG/lVToI2tnz2zoGycey09GkNBMFHGz52JkCoROV
         uUwv2mC5wcrbEX8+kMXTdUeGYx5l/x0TPNzfw3Z7kubW52MKEXIAgYWUSUDB0FgPCLu5
         eOuALSTOSd/K3fUyID6OMhTSfR9k7i7EVQEolt209fp/gYi7tz7NlhxSl5eDpFzVV2ql
         El+hOoXjKFIuwv+6QM/b29KK5iGV3ssIYeyk7kO8bpBkfkR4WdLD39LPaE86B1oJheQJ
         Rd6D5MicfoELUG9lufp2LKakyB9ry/DZ52yK3kgoRsT7vDk3n4CRLWX1drAWVHd/TdSR
         F0ew==
X-Gm-Message-State: AOAM533d2j6HHHl4w1GdNQ7h6L/uZb2s3qVY5p78VW5c6zXgJO6EM2dj
        j4VfXTAEZ0znsBzziL2P6dHqe2IYXRCjqLUAVO4=
X-Google-Smtp-Source: ABdhPJx0Wa9v8qLLUXn3Kt/byIyCrgScC4O9H9G9boJQkHlgVeto+M5yB3pVGluSMUIkV3fwQW7XiRNCbPlE+7YAids=
X-Received: by 2002:a17:906:4e46:: with SMTP id g6mr3512082ejw.366.1641462108780;
 Thu, 06 Jan 2022 01:41:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab4:98c8:0:0:0:0:0 with HTTP; Thu, 6 Jan 2022 01:41:48 -0800 (PST)
Reply-To: xiauchanyu@gmail.com
From:   Mrs Xiau Chan Yu <rw9251392@gmail.com>
Date:   Thu, 6 Jan 2022 01:41:48 -0800
Message-ID: <CAHL0NO+w5pdVLWu3yQ+GkorN+Q97i9QQ8MKXRrRfyCtqDooS2Q@mail.gmail.com>
Subject: =?UTF-8?Q?Sch=C3=B6nen_Tag=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

--=20
Sch=C3=B6ner Tag,

Ich bin Xiu Chan Yu, Kredit- und Marketingdirektor von Chong Hin
Bank, Hongkong, Chong Hing Bank Center, 24 Des Voeux Road Central,
Hongkong. Ich habe einen Gesch=C3=A4ftsvorschlag f=C3=BCr 13.991.674 $

Alle best=C3=A4tigbaren Dokumente zur Sicherung der Anspr=C3=BCche werden I=
hnen
ausgeh=C3=A4ndigt
vor Ihrer Annahme und sobald ich Ihre R=C3=BCcksendung erhalten habe
Bereitgestellt.

Gr=C3=BC=C3=9Fe
Xiau Chan Yu
